#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
using namespace std;

// Defining functor category C-Inst (Ob(C) equipped with Ob(Sets))
struct C_Inst {
    // Defining the objects in C-Inst: Ob(C)
    vector<int> _$;         // Prices
    vector<string> econ;    // Economy
    vector<string> first;   // First Class
    vector<string> str;     // Seat positions

    // Defining morphisms in C-Inst
    unordered_map<string, int> e_price;     // Economy price morphism
    unordered_map<string, int> f_price;     // First Class price morphism
    unordered_map<string, string> e_pos;    // Economy position morphism
    unordered_map<string, string> f_pos;    // First Class position morphism
};

// Defining functor category D-Inst (Ob(D) equipped with Ob(Sets))
struct D_Inst {
    // Defining the objects in D-Inst: Ob(D)
    vector<int> _$;         // Prices
    vector<string> seat;    // Airline Seats
    vector<string> str;     // Seat positions

    // Defining morphisms in D-Inst
    unordered_map<string, int> price;       // Price morphism
    unordered_map<string, string> pos;      // Position morphism
};

// Function to map C-Inst to D-Inst (Functor F: C --> D)
D_Inst mapFunctor(const C_Inst& c) {
    D_Inst d;

    // Sigma functor: Combine economy and first-class seats into unified data in D
    for (const auto& seat : c.econ) {
        d.seat.push_back(seat);
        d.price[seat] = c.e_price.at(seat);
        d.pos[seat] = c.e_pos.at(seat);
    }
    for (const auto& seat : c.first) {
        d.seat.push_back(seat);
        d.price[seat] = c.f_price.at(seat);
        d.pos[seat] = c.f_pos.at(seat);
    }
    // Pi functor: Pair those airline seats with same price and position => null set.
    return d;
}

int main() {
    // Define category C-Inst
    C_Inst I;

    // Assign objects to their respective sets
    I._$ = {20, 20, 20, 40, 40, 40}; // Prices
    I.econ = {"A", "B", "C"};        // Economy seats
    I.first = {"D", "E", "F"};       // First-Class seats
    I.str = {"1A", "1B", "1C", "1D", "1E", "1F"}; // Positions

    // Define morphisms
    I.e_price = {{"A", 20}, {"B", 20}, {"C", 20}};
    I.f_price = {{"D", 40}, {"E", 40}, {"F", 40}};
    I.e_pos = {{"A", "1A"}, {"B", "1B"}, {"C", "1C"}};
    I.f_pos = {{"D", "1D"}, {"E", "1E"}, {"F", "1F"}};

    // Display the objects and morphisms in the instance I
    cout << "Instance I:\n";

    // Display Economy seats with corresponding prices and positions
    for (const auto& seat : I.econ) {
        cout << "Seat: Economy - " << seat
            << ", Price: $" << I.e_price.at(seat)
            << ", Position: " << I.e_pos.at(seat) << endl;
    }

    // Display First Class seats with corresponding prices and positions
    for (const auto& seat : I.first) {
        cout << "Seat: First Class - " << seat
            << ", Price: $" << I.f_price.at(seat)
            << ", Position: " << I.f_pos.at(seat) << endl;
    }

    // Apply the functor to map C-Inst to D-Inst
    D_Inst J = mapFunctor(I);

    // Display the objects and morphisms in D-Inst
    cout << "Category D-Inst (Mapped Data):\n";
    for (const auto& seat : J.seat) {
        cout << "Seat: " << seat 
             << ", Price: $" << J.price[seat.substr(seat.find_last_of(" ") + 1)] 
             << ", Position: " << J.pos[seat.substr(seat.find_last_of(" ") + 1)] << endl;
    }

    return 0;
}
