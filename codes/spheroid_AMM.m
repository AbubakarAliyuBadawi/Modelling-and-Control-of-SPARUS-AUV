function spheroid_AMM = f(Length, Radius)
    rhow = 1000;
    a = Length/2;
    b = Radius;
    if a > b
        e = (1-(b/a)^2)^(1/2);
    else 
        e = (1-(a/b)^2)^(1/2);
    end
    alpha0 = 2*((1-e^2)/e^3)*(.5*log((1+e)/(1-e))-e);
    beta0 = (e^-2)-((1-e^2)/2*e^3)*log((1+e)/(1-e));
    k1 = alpha0/(2-alpha0);
    k2 = beta0/(2-beta0);
    k4 = 0;
    k5 = (e^4*(beta0-alpha0))/((2-e^2)*(2*e^2-(2-e^2)*(beta0-alpha0)));
    mdf = 4/3*rhow*pi*a*b^2;
    Ixdf = mdf*2*b^2/5;
    Iydf = mdf*(a^2+b^2)/5;
    Izdf = mdf*(a^2+b^2)/5;
    ma11 = k1*mdf;
    ma22 = k2*mdf;
    ma33 = k2*mdf;
    ma44 = k4*Ixdf;
    ma55 = k5*Iydf;
    ma66 = k5*Izdf;
    spheroid_AMM = [ma11 ma22 ma33 ma44 ma55 ma66];
end