function Para=Parameters()
global Para

%% Initial Speed and position in Earth-fixed frame

Para.ICPos = [0 0 20 0 0 0];    %position changed to 35
Para.ICSpeed = [0 0 0 0 0 0] ;



%% General parameters
Para.rho_water = 1000 ;                     % Masse volumique de l'eau (kg/m^3)
Para.R = 0.115 ;                             % Sparus Radius (m)
Para.L = 1.6;  	                            % Sparus length (m)
Para.m = 52 ; 	                            % Sparus mass (kg)
Para.mb = 52.1;                           	% Sparus buoyancy mass  (kg) 
Para.g = 9.81 ;                             % Earth Gravity (m*s^(-2))
Para.P = Para.m * Para.g;	                % Sparus weight (N)
Para.B = Para.mb * Para.g;	                % Buoyancy (N)

%% Center of gravity and Buoyancy position in body-fied frame

Para.xg = 0 ;    %x-positon of Center of gravity
Para.yg = 0 ;    %y-positon of Center of gravity
Para.zg = 0 ;    %z-positon of Center of gravity

Para.rg = [Para.xg Para.yg Para.zg]' ;


Para.xb = 0      ;    % x-positon of Center of Buoyancy
Para.yb = 0      ;    % y-positon of Center of Buoyancy
Para.zb = -0.02  ;    % z-positon of Center of Buoyancy

Para.rb = [Para.xb Para.yb Para.zb]' ;

%% Body positions

% Main Body S0;
Para.S0.r=[0,0,0]'; % Position (m)
% Antenna S1;
Para.S1.r=[-0.412 0 -0.2425]'; % Position (m)
% Thruster_RT S2;
Para.S2.r=[-0.59 0.175 0]'; % Position (m)
% Third Body S3: thruster 3;
Para.S3.r=[-0.59 -0.17 0]'; % Position (m)


%% Body Mass matrices

Para.Mb= [52 zeros(1,3) -0.1 0;
           0 52 0 0.1 0 -1.3;
           0 0 52 0 1.3 0;
           0 0.1 0 0.5 0 0;
           -0.1 0 1.3 0 9.4 0;
           0 1.3 0 0 0 9.5];
% % Main Body S0;
% Para.S0.m= 1; 
% Para.S0.I_xx = 1;    
% Para.S0.I_yy = 1;    
% Para.S0.I_zz = 1;    
% 
% Para.S0.Mb = -diag([Para.S0.m Para.S0.m Para.S0.m Para.S0.I_xx Para.S0.I_yy Para.S0.I_zz]) ; 
% 
% % First Body S1;
% Para.S1.m= 1; 
% Para.S1.I_xx = 1;    
% Para.S1.I_yy = 1;    
% Para.S1.I_zz = 1;    
% 
% Para.S1.Mb = -diag([Para.S1.m Para.S1.m Para.S1.m Para.S1.I_xx Para.S1.I_yy Para.S1.I_zz]) ; 
% 
% % Second Body S2;
% Para.S2.m= 1; 
% Para.S2.I_xx = 1;    
% Para.S2.I_yy = 1;    
% Para.S2.I_zz = 1;    
% 
% Para.S2.Mb = -diag([Para.S2.m Para.S2.m Para.S2.m Para.S2.I_xx Para.S2.I_yy Para.S2.I_zz]) ; 

%% Added Mass Matrix at center of gravity of sparus

Para.S0.Ma=[1.6037 0 0 0 -0.1066 0;
              0 57.8168 0 0.3412 0 2.3993;
              0 0 60.1997 0 -0.9416 0;
              0 0.3412 0 0.2082 0 -0.1348;
              -0.1066 0 -0.9416 0 10.8321 0;
              0 2.3993 0 -0.1348 0 9.9629];


%% Generalized mass matrix
% 
% Para.S0.Mg = Para.S0.Mb + Para.S0.Ma ; 
% Para.S1.Mg = Para.S1.Mb + Para.S1.Ma ;
% Para.S2.Mg = Para.S2.Mb + Para.S2.Ma ;

%Directamente de mi matriz del archivo transposing mass

% Para.Ma_total =Para.S0.Ma+Para.S1.Ma+Para.S2.Ma + Para.S3.Ma ;
% 
% Para.Mg=Para.Ma_total+Para.Mb;

Para.Ma_total =Para.S0.Ma;
Para.Mg=Para.Ma_total+Para.Mb;



%% Generalized coriolis matrix

% Computed in RovModel.m

% Friction matrices

% % Main Body S0;
% Para.S0.kuu = 0;    % surge
% Para.S0.kvv = 0;    % sway
% Para.S0.kww = 0;    % heave
% Para.S0.kpp = 0;    % roll
% Para.S0.kqq = 0;    % pitch
% Para.S0.krr = 0;    % yaw


Para.S0.kuu = 1.9880;    % surge
Para.S0.kvv = 342.0000;    % sway
Para.S0.kww = 342.0000;    % heave
Para.S0.kpp = 0.2082;    % roll
Para.S0.kqq = 43.7760;    % pitch
Para.S0.krr = 43.7760;    % yaw


Para.S0.Kq = -diag([Para.S0.kuu Para.S0.kvv Para.S0.kww Para.S0.kpp Para.S0.kqq Para.S0.krr]) ;    %Quadratic friction matrix

% % First Body S1 Antena;
% Para.S1.kuu = 0;    % surge
% Para.S1.kvv = 0;    % sway
% Para.S1.kww = 0;    % heave
% Para.S1.kpp = 0;    % roll
% Para.S1.kqq = 0;    % pitch
% Para.S1.krr = 0;    % yaw
% 
Para.S1.kuu = 19.8188;    % surge
Para.S1.kvv = 32.7275;    % sway
Para.S1.kww = 0;    % heave
Para.S1.kpp = 0;    % roll
Para.S1.kqq = 0;    % pitch
Para.S1.krr = 0;    % yaw

Para.S1.Kq = -diag([Para.S1.kuu Para.S1.kvv Para.S1.kww Para.S1.kpp Para.S1.kqq Para.S1.krr]) ;    %Quadratic friction matrix


% % Second Body S1 Thruster 1;
% Para.S2.kuu = 0;    % surge
% Para.S2.kvv = 0;    % sway
% Para.S2.kww = 0;    % heave
% Para.S2.kpp = 0;    % roll
% Para.S2.kqq = 0;    % pitch
% Para.S2.krr = 0;    % yaw

Para.S2.kuu = 2.33;    % surge
Para.S2.kvv = 24.9;    % sway
Para.S2.kww = 24.9;    % heave
Para.S2.kpp = 0;    % roll
Para.S2.kqq = 9.48e-03;    % pitch
Para.S2.krr = 9.48e-03;    % yaw

Para.S2.Kq = -diag([Para.S2.kuu Para.S2.kvv Para.S2.kww Para.S2.kpp Para.S2.kqq Para.S2.krr]) ;    %Quadratic friction matrix

% % Second Body S1 Thruster 3;
% Para.S3.kuu = 0;    % surge
% Para.S3.kvv = 0;    % sway
% Para.S3.kww = 0;    % heave
% Para.S3.kpp = 0;    % roll
% Para.S3.kqq = 0;    % pitch
% Para.S3.krr = 0;    % yaw

Para.S3.kuu = 2.33;    % surge
Para.S3.kvv = 24.9;    % sway
Para.S3.kww = 24.9;    % heave
Para.S3.kpp = 0;    % roll
Para.S3.kqq = 9.48e-03;    % pitch
Para.S3.krr = 9.48e-03;    % yaw

Para.S3.Kq = -diag([Para.S3.kuu Para.S3.kvv Para.S3.kww Para.S3.kpp Para.S3.kqq Para.S3.krr]) ;    %Quadratic friction matrix



%% Thruster modelling

Para.d1x = 0        ; 
Para.d1y = 0        ;
Para.d1z = 0.08     ;
Para.d2x = -0.566    ; 
Para.d2y = 0.185     ;
Para.d2z = 0        ;
Para.d3x = -0.566    ;
Para.d3y = -0.185    ;
Para.d3z = 0        ;


Para.rt1 = [Para.d1x, Para.d1y, Para.d1z]' ;
Para.rt2 = [Para.d2x, Para.d2y, Para.d2z]' ;
Para.rt3 = [Para.d3x, Para.d3y, Para.d3z]' ;


Para.rt = [Para.rt1 Para.rt2 Para.rt3] ;

%Thruster gains

Para.kt1 = 20    ;
Para.kt2 = 20    ;
Para.kt3 = 20    ;


%Thruster gain vectors

Para.Kt=[Para.kt1;Para.kt2;Para.kt3];

%Thruster time constants

Para.Tau1 = 0.4 ;
Para.Tau2 = 0.8 ;
Para.Tau3 = 0.8 ;


%Thruster time constant vectors

Para.Tau = [Para.Tau1;Para.Tau2;Para.Tau3] ;

% Mapping of thruster

Para.Eb_F = [0 1 1; 0 0 0; 1 0 0]; %%CHANGE
    
Para.Eb_M = [0 0 0; 0 0 0; 0 0.17 -0.17]  ;%%CHANGE

Para.Eb = [ Para.Eb_F ; Para.Eb_M ] ;

% Inverse Mapping of thruster
Para.Ebinv = pinv(Para.Eb) ;

Para.i=0;

end