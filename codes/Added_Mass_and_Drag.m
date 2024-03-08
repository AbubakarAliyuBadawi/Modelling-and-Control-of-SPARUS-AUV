clear all

M_rb = [52   0    0    0   -0.1  0;
        0    52   0    0.1  0   -1.3;
        0    0    52   0    1.3  0;
        0    0.1  0    0.5  0    0;
       -0.1  0    1.3  0    9.4  0;
        0   -1.3  0    0    0    9.5]

p_w = 1000; % kg/m^3
R = 0.1125;  % m
L = 1.6;
g = 9.81;
h = 0.2149; % h of cone
r_b = [0 0 -0.02]';
thr1_pos = [-0.53  0.174 0]';
thr2_pos = [-0.53 -0.174 0]';
sens1_pos = [0.364 -0.021 -0.085]';
sens2_pos = [0.44 0 -0.14]';

% Added Mass Effect of Main Hull

e = sqrt(1-(R.^2)/(L.^2));
a0 = 2.*((1-e.^2)/e.^3)*(0.5.*log((1+e/(1-e))) - e);
k1 = a0/(2-a0);
m_df = 4/3.*p_w.*pi.*L.*R.^2;
m_a11 = k1 .* m_df;

%slender body theorem

%fun0 = @(x) pi*(R^2)*p_w;
%q0 = integral(fun0, -L/2 + h, L/2 - R);
q0 = pi.*(R.^2).*p_w.*(L-h-R);

fun1 = @(x) pi.*((R.^2)-((x-L/2+R).^2)).*p_w;
q1 = integral(fun1, L/2 - R, L/2);

fun2 = @(x) pi.*((R.^2).*((h-(x+L/2+h)).^2)/(h.^2)).*p_w;
q2 = integral(fun2, -L/2, -L/2 + h);

m_a22 = q0 + q1 + q2;
m_a33 = m_a22;

% m_a55 m_a66
fun10 = @(x) pi.*(R.^2).*p_w.*x.^2;
q10 = integral(fun10, -L/2 + h, L/2 - R);

fun11 = @(x) pi.*((R.^2)-((x-L/2+R).^2)).*p_w.*x.^2;
q11 = integral(fun11, L/2 - R, L/2);

fun12 = @(x) pi.*((R.^2).*((h-(x+L/2+h)).^2)/(h.^2)).*p_w.*x.^2;
q12 = integral(fun12, -L/2, -L/2 + h);

m_a55 = q10 + q11 + q12;
m_a66 = m_a55;

% m_a26 m_a62
fun3 = @(x) pi.*(R.^2).*p_w.*x;
q3 = integral(fun3, -L/2 + h, L/2 - R);

fun4 = @(x) pi.*((R.^2)-((x-L/2+R).^2)).*p_w.*x;
q4 = integral(fun4, L/2 - R, L/2);

fun5 = @(x) pi.*((R.^2).*((h-(x+L/2+h)).^2)/(h.^2)).*p_w.*x;
q5 = integral(fun5, -L/2, -L/2 + h);

m_a26 = q3 + q4 + q5; m_a62 = m_a26;

%m_a35 m_a53

fun6 = @(x) pi.*(R.^2).*p_w.*x;
q6 = -integral(fun6, -L/2 + h, L/2 - R);

fun7 = @(x) pi.*((R.^2)-((x-L/2+R).^2)).*p_w.*x;
q7 = -integral(fun7, L/2 - R, L/2);

fun8 = @(x) pi.*((R.^2).*((h-(x+L/2+h)).^2)/(h.^2)).*p_w.*x;
q8 = -integral(fun8, -L/2, -L/2 + h);

m_a35 = q6 + q7 + q8; m_a53 = m_a35;
m_a44 = 0;

M_a_hull = [m_a11 0     0     0     0     0;
              0   m_a22 0     0     0     m_a26;
              0   0     m_a33 0     m_a35 0;
              0   0     0     m_a44 0     0;
              0   0     m_a53 0     m_a55 0;
              0   m_a62 0     0     0     m_a66]


S_hull_b = [0 -r_b(3) r_b(2) ; r_b(3) 0 -r_b(1) ; -r_b(2) r_b(1) 0];
H_hull_b = [eye(3)     S_hull_b';
         zeros(3) eye(3)];

M_hull_gcb = H_hull_b' * M_a_hull * H_hull_b

% antenna added mass
a = 0.07/4;
b = 0.07/2;
radius = 0.065;
length = 0.265;
C_a = 1.70;
C_b = 1.36;

%m11
%zun0 = @(z) C_a*pi.*(a.^2).*p_w;
%z0 = integral(zun0, -length/2, length/2);
z0 = C_a*pi.*(a.^2).*p_w.*(length);

m_ant_11 = z0; 

%m22
%zun1 = @(z) C_b*pi.*(b.^2).*p_w;
%z1 = integral(zun1, -length/2, length/2);
z1 = C_b*pi.*(b.^2).*p_w.*(length);

m_ant_22 = z1; 
m_ant_33 = 0; % will be calculated using k factor

% m44
zun2 = @(z) C_a*pi.*(b.^2).*p_w.*z.^2;
z2 = integral(zun2, -length/2, length/2);
m_ant_44 = z2;

% m55
zun3 = @(z) C_b*pi.*(a.^2).*p_w.*z.^2;
z3 = integral(zun3, -length/2, length/2);
m_ant_55 = z3;

%m66
beta1 = 0.15;
%zun4 = @(z) beta1*pi.*(a.^4).*p_w;
%z4 = integral(zun4, -length/2, length/2);
z4 = beta1*pi.*(a.^4).*p_w.*(length);

m_ant_66 = z4; 

%m15 m51
zun5 = @(z) C_b*pi.*(a.^2).*p_w.*z;
z5 = -integral(zun5, -length/2, length/2);

m_ant_15 = z5;
m_ant_51 = m_ant_15;

%m24 m42
zun6 = @(z) C_a*pi.*(b.^2).*p_w.*z;
z6 = integral(zun6, -length/2, length/2);

m_ant_24 = z6;
m_ant_42 = m_ant_24;


M_a_antenna= [m_ant_11 0         0        0        m_ant_15 0;
              0         m_ant_22 0        m_ant_24 0        0;
              0         0        m_ant_33 0        0        0;
              0         m_ant_42 0        m_ant_44 0        0;
              m_ant_51  0        0        0        m_ant_55 0;
              0         0        0        0        0        m_ant_66]



r_ant_g = [-0.395 0 -0.246];
r_ant_b = r_ant_g + r_b;
S_ant = [0 -r_ant_g(3) r_ant_g(2) ; r_ant_g(3) 0 -r_ant_g(1) ; -r_ant_g(2) r_ant_g(1) 0];
H_ant = [eye(3)     S_ant';
         zeros(3) eye(3)];

S_ant_b = [0 -r_ant_b(3) r_ant_b(2) ; r_ant_b(3) 0 -r_ant_b(1) ; -r_ant_b(2) r_ant_b(1) 0];
H_ant_b = [eye(3)     S_ant_b';
         zeros(3) eye(3)];

M_ant_gcg = H_ant' * M_a_antenna * H_ant;
M_ant_gcb = H_ant_b' * M_a_antenna * H_ant_b;

% thruster1 added mass

r_thr = 0.05;
l_thr = 0.240;

% m11
e_1 = sqrt(1-(r_thr.^2)/(l_thr.^2));
a0_1 = 2.*(1-(e_1.^2))/(e_1.^3)*(0.5.*log((1+e_1)/(1-e_1)) - e_1);
k1_1 = a0_1 / (2 - a0_1);
m_df_1 = 4/3.*p_w.*pi.*l_thr.*r_thr.^2;
m_thr11 = k1_1 .* m_df_1;

% m22 m33 m44
%thr0 = @(x) pi.*(r_thr.^2).*p_w;
%t0 = integral(thr0, -l_thr/2, l_thr/2);
t0 = pi.*(r_thr.^2).*p_w.*(l_thr);

m_thr22 = 0;
m_thr33 = t0;
m_thr44 = 0;

% m55 m66

thr1 = @(x) pi.*(r_thr.^2).*p_w.*x.^2;
t1 = integral(thr1, -l_thr/2, l_thr/2);

m_thr55 = t1;
m_thr66 = m_thr55;

% m26 m62

thr2 = @(x) pi.*(r_thr.^2).*p_w.*x;
t2 = integral(thr2, -l_thr/2, l_thr/2);


m_thr26 = t2; m_thr62 = m_thr26;

%ma35 ma53

thr3 = @(x) pi.*(r_thr.^2).*p_w.*x;
t3 = -integral(thr3, -l_thr/2, l_thr/2);

m_thr35 = t3; m_thr53 = m_thr35;


M_a_thr1= [m_thr11 0        0        0        0        0;
              0    m_thr22  0        0        0        m_thr26;
              0    0        m_thr33  0        m_thr35  0;
              0    0        0        m_thr44  0        0;
              0    0        m_thr53  0        m_thr55  0;
              0    m_thr62  0        0        0        m_thr66]

r_thr1 = [-0.532 0.174 0];
S_thr1 = [0 -r_thr1(3) r_thr1(2) ; r_thr1(3) 0 -r_thr1(1) ; -r_thr1(2) r_thr1(1) 0];
H_thr1 = [eye(3)     S_thr1';
         zeros(3)   eye(3)];

M_thr1_gcg = H_thr1' * M_a_thr1 * H_thr1;

r_thr1_b = r_thr1 + r_b;
S_thr_b = [0 -r_thr1_b(3) r_thr1_b(2) ; r_thr1_b(3) 0 -r_thr1_b(1) ; -r_thr1_b(2) r_thr1_b(1) 0];
H_thr_b = [eye(3)     S_thr_b';
         zeros(3) eye(3)];

M_thr1_gcb = H_thr_b' * M_a_thr1 * H_thr_b;


% thruster2 added mass

M_a_thr2 = M_a_thr1;

r_thr2 = [-0.532 -0.174 0];
S_thr2 = [0 -r_thr2(3) r_thr2(2) ; r_thr2(3) 0 -r_thr2(1) ; -r_thr2(2) r_thr2(1) 0];
H_thr2 = [eye(3)     S_thr2';
         zeros(3)   eye(3)];

r_thr2_b = r_thr2 + r_b;
S_thr2_b = [0 -r_thr2_b(3) r_thr2_b(2) ; r_thr2_b(3) 0 -r_thr2_b(1) ; -r_thr2_b(2) r_thr2_b(1) 0];
H_thr2_b = [eye(3)     S_thr2_b';
         zeros(3)   eye(3)];

M_thr2_gcb = H_thr2_b' * M_a_thr2 * H_thr2_b;
M_thr2_gcg = H_thr2' * M_a_thr2 * H_thr2;

M_a_total = M_a_hull + M_ant_gcg + M_thr1_gcg + M_thr2_gcg
M_a_total_cb = M_hull_gcb + M_ant_gcb + M_thr1_gcb + M_thr2_gcb

%% DRAG MATRICES

% hull
% 3d elipsoid in x
D = 2*R;
cd11_h = 0.1;
Sx_h = (pi*D^2)/4;
k11_h = 0.5*p_w*Sx_h*cd11_h;
% 2d rectangular in y
cd22_h = 1.9;
k22_h = 0.5*p_w*cd22_h*D*L;
% 2d rectangular in z
k33_h = k22_h;
k44_h = 0;
k55_h = 1/64*p_w*L^4*cd22_h*D;
k66_h = k55_h;

drag_hull = [k11_h 0     0     0     0     0;
             0     k22_h 0     0     0     0;
             0     0     k33_h 0     0     0;
             0     0     0     k44_h 0     0;
             0     0     0     0     k55_h 0;
             0     0     0     0     0     k66_h]
% antenna 

% 3d rectangular plate in x
D_ant = 2*radius;
cd11_a = 1.10 + 0.02 * (length/D_ant + D_ant/length);
Sx_ant = D_ant*length;
k11_a = 0.5*p_w*Sx_ant*cd11_a;

%cd11_a = 1.10 + 0.02 * (D_ant/length + length/D_ant);
%k11_a = 0.5*p_w*cd11_a*D_ant*length;

% 2d rectangular in y
cd22_a = 1.9;
k22_a = 0.5*p_w*cd22_a*D_ant*length;
k33_a = 0;
k44_a = 0;
k55_a = 0;
k66_a = 0;
%k66_a = 1/64*p_w*L^4*cd22_a*D_ant;

drag_antenna = [k11_a 0     0     0     0     0;
                0     k22_a 0     0     0     0;
                0     0     k33_a 0     0     0;
                0     0     0     k44_a 0     0;
                0     0     0     0     k55_a 0;
                0     0     0     0     0     k66_a]

% thruster 1 and 2
% 3d finite cylinder in x 
D_thr = 2 * r_thr;
cd11_t = 0.9;
Sx_t = (pi*D_thr^2)/4;
k11_t = 0.5*p_w*Sx_t*cd11_t;

% 2d rectangular in z
k22_t = 0;
cd33_t = 2.5;
k33_t = 0.5*p_w*cd33_t*D_thr*l_thr;
k44_t = 0;
%k55_t = 1/64*p_w*L^4*cd33_t*D_thr;
k55_t = 0;
k66_t = 0;

drag_thruster = [k11_t 0     0     0     0     0;
                 0     k22_t 0     0     0     0;
                 0     0     k33_t 0     0     0;
                 0     0     0     k44_t 0     0;
                 0     0     0     0     k55_t 0;
                 0     0     0     0     0     k66_t]
  
%%%%
% sensor 1 and 2

D_sensor1 = 0.04245;
D_sensor2 = 0.05188;
L_sensor1 = 0.02830;
L_sensor2 = 0.05094;

%sensor1
% 3d finite cylinder in x
cd11_t = 0.5;
Sx_t = D_sensor1*L_sensor1;
k11_t = 0.5*p_w*Sx_t*cd11_t;

% 2d rectangular in y

cd22_t = 2;
k22_t = 0.5*p_w*cd22_t*D_sensor1*D_sensor1;
k33_t = 0;
k44_t = 0;
k55_t = 0;
k66_t = 0;

drag_sensor1 = [k11_t 0     0     0     0     0;
                 0     k22_t 0     0     0     0;
                 0     0     k33_t 0     0     0;
                 0     0     0     k44_t 0     0;
                 0     0     0     0     k55_t 0;
                 0     0     0     0     0     k66_t]

%sensor2
% 3d finite cylinder in x
cd11_t = 0.6;
Sx_t = D_sensor2*L_sensor2;
k11_t = 0.5*p_w*Sx_t*cd11_t;

% 2d rectangular in y

cd22_t = 2;
k22_t = 0.5*p_w*cd22_t*D_sensor2*D_sensor2;
k33_t = 0;
k44_t = 0;
k55_t = 0;
k66_t = 0;

drag_sensor2 = [k11_t 0     0     0     0     0;
                 0     k22_t 0     0     0     0;
                 0     0     k33_t 0     0     0;
                 0     0     0     k44_t 0     0;
                 0     0     0     0     k55_t 0;
                 0     0     0     0     0     k66_t]

M_a_other_bodies = M_a_antenna + (M_a_thr1*2)
totol_drag = drag_hull + drag_antenna + drag_thruster + drag_sensor1 + drag_sensor2