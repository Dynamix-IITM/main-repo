using Catlab, Catlab.CategoricalAlgebra, Catlab.Programs, Catlab.WiringDiagrams, Catlab.Graphics 
using AlgebraicPetri 
using AlgebraicDynamics.UWDDynam 

using DifferentialEquations 

using LabelledArrays 
using Plots

function create_petri_net(filename)
    f = open(filename, "r")

    petri_net = LabelledPetriNet()

    places = [(Symbol(s), add_species!(petri_net, sname=Symbol(s))) for s in split(readline(f), (','))]
    transitions = [(Symbol(s), add_transition!(petri_net, tname=Symbol(s))) for s in split(readline(f), (','))]
    
    function get_index(list, symbol)
        for item in list
            if item[1] == symbol
                return item[2]
            end
        end
        return Nothing
    end
    
    i = 1
    while !eof(f)
        details = split(readline(f), (':'))
        input_details = [Symbol(s) for s in split(details[1], (','))]
        output_details = [Symbol(s) for s in split(details[2], (','))]
    
        for ip in input_details
            add_input!(petri_net, transitions[i][2], get_index(places, ip))
        end 
    
        for op in output_details
            add_output!(petri_net, transitions[i][2], get_index(places, op))
        end 
    
        i += 1
    end  
    
    return petri_net
end

function create_uwd(filename)
    f = open(filename, "r")

    petri_net = LabelledPetriNet()

    places = [(Symbol(s), add_species!(petri_net, sname=Symbol(s))) for s in split(readline(f), (','))]
    transitions = [(Symbol(s), add_transition!(petri_net, tname=Symbol(s))) for s in split(readline(f), (','))]
    
    function get_index(list, symbol)
        for item in list
            if item[1] == symbol
                return item[2]
            end
        end
        return Nothing
    end
    
    i = 1
    while !eof(f)
        details = split(readline(f), (':'))
        input_details = [Symbol(s) for s in split(details[1], (','))]
        output_details = [Symbol(s) for s in split(details[2], (','))]
    
        for ip in input_details 
            add_input!(petri_net, transitions[i][2], get_index(places, ip))
        end 
    
        for op in output_details
            add_output!(petri_net, transitions[i][2], get_index(places, op))
        end 
    
        i += 1
    end  
    
    return petri_net
end

a = @relation (:A, :B) begin
    
end