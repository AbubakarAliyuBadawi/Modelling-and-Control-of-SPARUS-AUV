function [AccG] = RovModel(Thrust,PosE,VitB)

global Para

%% Attitudes in earth frame
% z=PosE(3,1);
phi     = PosE(4,1)	;
theta   = PosE(5,1)	;

%% Gravity Force

Fg = 1* [-Para.P * sin(theta) ;
        Para.P * cos(theta)*sin(phi) ;
        Para.P * cos(theta)*cos(phi) ;
        0 ;
        0 ;
        0 ];
    
% Expressed in b and computed in G
    
%% Force d'Archimède

Fa_F = [Para.B * sin(theta) ;
        -Para.B * cos(theta)*sin(phi) ;
        -Para.B * cos(theta)*cos(phi) ;
        ];
%  Expressed in b


Fa_M = S_(Para.rb-Para.rg) * Fa_F ; % Computed in G

Fa = [ Fa_F ; Fa_M ] ;
%  Expressed in b and computed in G

%% Force de Coriolis

u = VitB(1,1);
v = VitB(2,1);
w = VitB(3,1);
p = VitB(4,1)   ;   %Body fixed velocity roll (rad*s^(-1))
q = VitB(5,1)   ;   %Body fixed velocity pitch (rad*s^(-1))
r = VitB(6,1)   ;   %Body fixed velocity yaw (rad*s^(-1))
% W_ = [p;q;r]     ;  %General vector

M11 = Para.Mg(1:3, 1:3);
M12 = Para.Mg(4:6, 4:6);
M21 = Para.Mg(4:6, 1:3);
M22 = Para.Mg(4:6, 4:6); 

v1 = [u; v; w]; 
v2 = [p; q; r];

% Wb :
% Wb = [  S_(W_)       zeros(3,3) ;
%         zeros(3,3)      S_(W_)       ];
C = [ zeros(3, 3)     -S_(M11*v1 + M12*v2)
      -S_(M11*v1 + M12*v2)   -S_(M21*v1 + M22*v2)]; 
% General coriolis matrix : -> not correct, see slide 95
% C_all = Wb * Para.Mg ;

%coriolis Force :
Fc = C* VitB   ;

%% Friction forces -> need to be transposed to centre of gravity
% use the h function / h_matrix 
Vit_0=VitB;
Ff_0 =  Para.S0.Kq * abs(Vit_0).*Vit_0 ;

Vit_1=VitB;
Ff_1 =  Para.S1.Kq * abs(Vit_1).*Vit_1 ;

Vit_2=VitB;
Ff_2 =  Para.S0.Kq * abs(Vit_2).*Vit_2 ;

%% Propulsions Forces
Fp = Para.Eb * Thrust ;

%% Accelearion computation :
AccG = Para.Mg\ (Ff_0+Ff_1+Ff_2 +Fa + Fg+ Fp- Fc) ; % Mg\ = Mg^-1 computed at the gravity center of the Sparus


