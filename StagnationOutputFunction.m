function fun = StagnationOutputFunction(relTol)

lastfval = [];
slowstepcount = [];
fun = @outputfun;

    function stop = outputfun(x, optimValues, state)
        stop = false;
        switch state
            case 'init'
                % Reset lastfval at the beginning of the optimization
                lastfval = [];
                slowstepcount = 0;
            case 'iter'
                if isfield(optimValues, 'fval')
                    % fmincon case
                    fval = optimValues.fval;
                else
                    % lsqnonlin case
                    fval = optimValues.resnorm;
                end
                if ~isempty(lastfval)
                    deltaG = lastfval - fval;
                    isslowstep = deltaG/lastfval < relTol;
                    if isslowstep
                        slowstepcount = slowstepcount + 1;
                    else
                        slowstepcount = 0;
                    end
                end
                if slowstepcount >= 5
                    stop = true;
                end
                lastfval = fval;
        end
    end

end