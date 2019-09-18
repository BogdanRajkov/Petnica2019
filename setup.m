function [] = setup(r_arr)
    hold on;
    phi = 0:pi/50:2*pi;
    for i = 1:size(r_arr, 1)
        plot(r_arr(i)*sin(phi), r_arr(i)*cos(phi), 'k');
    end
end
