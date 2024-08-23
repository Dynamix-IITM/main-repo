using Catlab, Catlab.CategoricalAlgebra, Catlab.Programs, Catlab.WiringDiagrams, Catlab.Graphics 
using AlgebraicPetri 
using AlgebraicDynamics.UWDDynam 
using LabelledArrays 
using DifferentialEquations 
using Plots

# A Lotka Volterra Model dealing with Foxes and Rabbits
LV = Open(LabelledPetriNet(
    [:Fox, :Rabbit], 
    :birth_rabbit => ((:Rabbit) => (:Rabbit)),
    :death_fox => ((:Fox) => (:Fox)),
    :birth_fox => ((:Rabbit, :Fox) => (:Fox)),
    :eaten_rabbit => ((:Rabbit, :Fox) => (:Rabbit))
    ))

a = LabelledPetriNet()
oapply()


# Navin's Pigeon Model
N = Open(LabelledPetriNet([:Fox, :Pigeon], 
    :birth_pigeon => ((:Pigeon) => (:Pigeon)),
    :death_pigeon => ((:Pigeon) => (:Pigeon)),
    :pigeon_eaten => ((:Pigeon, :Fox) => (:Pigeon))
)
)

to_graphviz(LV)
to_graphviz(N)

forest_composition_pattern = @relation (Foxes, Pigeons, Rabbits) where (Foxes, Pigeons, Rabbits) begin
    lotka(Foxes, Rabbits)
    navin(Foxes, Pigeons)
end

to_graphviz(forest_composition_pattern, box_labels = :name, junction_labels = :variable)

forest_model = oapply(forest_composition_pattern, 
    Dict(   :lotka => LV,   :navin => N )
)

to_graphviz(forest_model)