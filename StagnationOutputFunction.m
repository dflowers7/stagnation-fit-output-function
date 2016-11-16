function fun = StagnationOutputFunction(relTol)

lastfval = [];
fun = @outputfun;

    function stop = outputfun(x, optimValues, state)
        fval = optimValues.fval;
        if ~isempty(lastfval)
            deltaG = lastfval - fval;
            stop = deltaG/lastfval < relTol;
        end
        lastfval = fval;
    end

end