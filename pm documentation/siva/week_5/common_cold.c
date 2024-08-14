#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Defining a datatype called Individual
struct individual {
    char state;
    char hygiene;
    double time_in_R;
};

// Define the system structure
struct system {
    int *Sv; // Array to hold counts of Susceptible with good hygiene over time
    int *Sn; // Array to hold counts of Susceptible with poor hygiene over time
    int *Iv; // Array to hold counts of Infected with good hygiene over time
    int *In; // Array to hold counts of Infected with poor hygiene over time
    int *R;  // Array to hold counts of Recovered individuals over time
    int size; // Size of each array
};

// Function prototypes
void initialize_array(struct individual *individuals, int Sv, int Sn, int Iv, int In);
void update_individuals(struct individual *individuals, int totalSize, double beta, double alpha_0, double alpha_max, double gamma_0, double gamma_max, double delta_t, double tau, int *Sv, int *Sn, int *Iv, int *In, int *R);
void initialize_system(struct system *sys, int size);
void free_system(struct system *sys);
void print_system(struct system *sys, double delta_t);
void simulate(struct individual *individuals, struct system *sys, int totalSize, double beta, double alpha_0, double alpha_max, double gamma_0, double gamma_max, double tau, double delta_t, double total_time);
double calculate_alpha(int In, int Sn, double alpha_0, double alpha_max);
double calculate_gamma(int In, int Iv, double gamma_0, double gamma_max);

// Main function
int main() {

    srand(time(NULL));
    int Sv = 200;
    int Sn = 200;
    int Iv = 10;
    int In = 30;

    double alpha_0 = 0.1;
    double alpha_max = 0.5;
    double gamma_0 = 0.1;
    double gamma_max = 0.3;
    double beta = 0.2;
    double tau = 5.0;
    double delta_t = 0.1;
    double total_time = 100.0;

    int numIterations = (int)(total_time / delta_t);
    int totalSize = Sv + Sn + Iv + In;

    // Allocate memory for the array of individuals
    struct individual *individuals = (struct individual *)malloc(totalSize * sizeof(struct individual));
    if (individuals == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    // Initialize the arrays
    initialize_array(individuals, Sv, Sn, Iv, In);

    // Initialize the system structure
    struct system sys;
    initialize_system(&sys, numIterations);

    // Simulate the model
    simulate(individuals, &sys, totalSize, beta, alpha_0, alpha_max, gamma_0, gamma_max, tau, delta_t, total_time);

    // Print the system state over time
    print_system(&sys, delta_t);

    // Free the allocated memory
    free(individuals);
    free_system(&sys);

    return 0;
}


// Function to initialize the array of individuals
void initialize_array(struct individual *individuals, int Sv, int Sn, int Iv, int In) {
    int index = 0;

    // Initialize Sv (Susceptible with good hygiene)
    for (int i = 0; i < Sv; i++) {
        individuals[index].state = 'S';
        individuals[index].hygiene = 'v';
        individuals[index].time_in_R = 0.0;
        index++;
    }

    // Initialize Sn (Susceptible with poor hygiene)
    for (int i = 0; i < Sn; i++) {
        individuals[index].state = 'S';
        individuals[index].hygiene = 'n';
        individuals[index].time_in_R = 0.0;
        index++;
    }

    // Initialize Iv (Infected with good hygiene)
    for (int i = 0; i < Iv; i++) {
        individuals[index].state = 'I';
        individuals[index].hygiene = 'v';
        individuals[index].time_in_R = 0.0;
        index++;
    }

    // Initialize In (Infected with poor hygiene)
    for (int i = 0; i < In; i++) {
        individuals[index].state = 'I';
        individuals[index].hygiene = 'n';
        individuals[index].time_in_R = 0.0;
        index++;
    }
}

// Function to update individuals based on the simulation rules
void update_individuals(struct individual *individuals, int totalSize, double beta, double alpha_0, double alpha_max, double gamma_0, double gamma_max, double delta_t, double tau, int *Sv, int *Sn, int *Iv, int *In, int *R) {
    double alpha = calculate_alpha(*In, *Sn, alpha_0, alpha_max);
    double gamma = calculate_gamma(*In, *Iv, gamma_0, gamma_max);
    
    for (int i = 0; i < totalSize; i++) {
        if (individuals[i].state == 'S') {
            // Transition from Susceptible to Infected
            double infect_prob = ((individuals[i].hygiene == 'v') ? beta * (*In) / totalSize : alpha) * delta_t;
            if ((double)rand() / RAND_MAX < infect_prob) {
                individuals[i].state = 'I';
                if (individuals[i].hygiene == 'v'){
                    (*Sv)--;
                    (*Iv)++;
                }
                else{ 
                    (*Sn)--;
                    (*In)++;
                }
            }
        } else if (individuals[i].state == 'I') {
            // Transition from Infected to Recovered
            double recovery_prob = ((individuals[i].hygiene == 'v') ? gamma_max : gamma) * delta_t;
            if ((double)rand() / RAND_MAX < recovery_prob) {
                individuals[i].state = 'R';
                individuals[i].time_in_R = 0.0;
                if (individuals[i].hygiene == 'v'){
                    (*Iv)--;
                }else {
                    (*In)--;
                }
                (*R)++;
            }
        } else if (individuals[i].state == 'R') {
            // Update time in R
            individuals[i].time_in_R += delta_t;
            // Transition from Recovered to Susceptible if time in R exceeds tau
            if (individuals[i].time_in_R >= tau) {
                individuals[i].state = 'S';
                (*R)--;
                if (individuals[i].hygiene == 'v') (*Sv)++;
                else (*Sn)++;
            }
        }
    }
}


// Function to initialize the system structure
void initialize_system(struct system *sys, int size) {
    sys->Sv = (int *)malloc(size * sizeof(int));
    sys->Sn = (int *)malloc(size * sizeof(int));
    sys->Iv = (int *)malloc(size * sizeof(int));
    sys->In = (int *)malloc(size * sizeof(int));
    sys->R = (int *)malloc(size * sizeof(int));
    sys->size = size;

    if (sys->Sv == NULL || sys->Sn == NULL || sys->Iv == NULL || sys->In == NULL || sys->R == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize the arrays to zero
    for (int i = 0; i < size; i++) {
        sys->Sv[i] = 0;
        sys->Sn[i] = 0;
        sys->Iv[i] = 0;
        sys->In[i] = 0;
        sys->R[i] = 0;
    }
}

// Function to free the system structure
void free_system(struct system *sys) {
    free(sys->Sv);
    free(sys->Sn);
    free(sys->Iv);
    free(sys->In);
    free(sys->R);
}

// Function to simulate the model
void simulate(struct individual *individuals, struct system *sys, int totalSize, double beta, double alpha_0, double alpha_max, double gamma_0, double gamma_max, double tau, double delta_t, double total_time) {
    int Sv = 0, Sn = 0, Iv = 0, In = 0, R = 0;

    // Count initial states
    for (int i = 0; i < totalSize; i++) {
        if (individuals[i].state == 'S') {
            if (individuals[i].hygiene == 'v') Sv++;
            else Sn++;
        } else if (individuals[i].state == 'I') {
            if (individuals[i].hygiene == 'v') Iv++;
            else In++;
        }
    }

    sys->Sv[0] = Sv;
    sys->Sn[0] = Sn;
    sys->Iv[0] = Iv;
    sys->In[0] = In;
    sys->R[0] = R;
    
    for (double time = delta_t; time < total_time; time += delta_t) {
        update_individuals(individuals, totalSize, beta, alpha_0, alpha_max, gamma_0, gamma_max, delta_t, tau, &Sv, &Sn, &Iv, &In, &R);

        int iteration = (int)(time / delta_t);
        sys->Sv[iteration] = Sv;
        sys->Sn[iteration] = Sn;
        sys->Iv[iteration] = Iv;
        sys->In[iteration] = In;
        sys->R[iteration] = R;
    }
}


// Function to print the system state over time to a file
void print_system(struct system *sys, double delta_t) {
    char* filename = "model.txt";
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        fprintf(stderr, "Error opening file: %s\n", filename);
        return;
    }

    int numIterations = sys->size;
    fprintf(file, "Time\tSv\tSn\tIv\tIn\tR\n");
    for (int i = 0; i < numIterations; i++) {
        fprintf(file, "%.2f\t%d\t%d\t%d\t%d\t%d\n", 
                i * delta_t, 
                sys->Sv[i], 
                sys->Sn[i], 
                sys->Iv[i], 
                sys->In[i], 
                sys->R[i]);
    }

    fclose(file);
}

// Function to calculate alpha based on the number of infected individuals
double calculate_alpha(int In, int Sn, double alpha_0, double alpha_max) {
    if (Sn == 0) return alpha_max; // Avoid division by zero
    return alpha_0 + (alpha_max - alpha_0) * ((double)In / Sn);
}

// Function to calculate gamma based on the number of infected individuals in Sn
double calculate_gamma(int In, int Sn, double gamma_0, double gamma_max) {
    if (Sn == 0) return gamma_0; // Avoid division by zero
    return gamma_0 + (gamma_max - gamma_0) * ((double)In / Sn);
}
