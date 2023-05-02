states_needed = Simulink.BlockDiagram.getInitialState(loop_model);
states_to_remove = [];

%modify initial state labels
for l = 1:numElements(states_cur)
    %replace name from sc_real -> sc_model
    nm = states_cur{l}.Name;
    nm_new = strrep(nm, sc_real, sc_model);

    %check if state exists in needed states
    check_in_states_needed = contains(states_needed{l}.Name, nm_new);
    if any(check_in_states_needed)
        %get last value
        val_new = getsamples(states_cur{l}.Values, length(states_cur{l}.Values.Time));

        %fix blockpath
        bp = states_cur{l}.BlockPath;
        bp_new = Simulink.BlockPath({strrep(bp.getBlock(1), loop_real, loop_model), ...
                                    strrep(bp.getBlock(2), sc_real, sc_model)});

        %set new state labels
        states_cur{l}.Name = nm_new;
        states_cur{l}.Values = val_new;
        states_cur{l}.BlockPath = bp_new;
    else
        states_to_remove = [states_to_remove l];
    end
end

states_cur = removeElement(states_cur, states_to_remove);

states_cur

%sim(loop_model, 'LoadInitialState', 'on', 'InitialState', 'states_cur', 'StopTime', '20')