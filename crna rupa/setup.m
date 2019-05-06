function [] = setup()
    hold on;
    x = -5:0.1:5;
    plot(x,  sqrt(25-x^2));
    plot(x, -sqrt(25-x^2));
    hold off;
end
