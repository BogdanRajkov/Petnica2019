function test_numerika()
    clc;
        
    hold on;
    y = linspace(0.1, 5, 501);
    cosOt_arr = arrayfun(@(x) zrak([1 1], [-floor(sqrt(25-x^2)*100+1)/100 x], [1 0]), y, 'UniformOutput', false);

    save('kosinus.mat')
    plot(y, cellfun(@(x)x(1), cosOt_arr));
    plot(y, cellfun(@(x)x(2), cosOt_arr));
    hold off;
    saveas(gcf, strcat(char(39), 'rezultati', char(39), '/', datestr(now, 'yyyy-mm-dd HH-MM'), '.png'));
    
end