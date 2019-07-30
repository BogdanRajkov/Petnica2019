function test_numerika()
    clc;
        
    hold on;
    y = linspace(.1, 4.9, 9700);
    sinOt_arr = arrayfun(@(x) zrak([1 1], [-6 x], [1 0]), y, 'UniformOutput', false);
    
    save('sinus.mat')
    plot(y, cellfun(@(x)x(1), sinOt_arr));
    plot(y, cellfun(@(x)x(2), sinOt_arr));
    hold off;
    saveas(gcf, strcat(char(39), 'rezultati', char(39), '/', datestr(now, 'yyyy-mm-dd HH-MM'), '.png'));
    %%
    tic
    for i = 0:0.0001:1
        index(i);
    end
    toc
end