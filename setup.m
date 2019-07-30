function [] = setup()
    hold on;
    phi = 0:pi/50:2*pi;
    plot(5*cos(phi), 5*sin(phi), 'k');
    plot(2.5*cos(phi), 2.5*sin(phi), 'k');
end
