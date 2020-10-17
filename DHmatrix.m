% Trasforma i parametri DH nelle matrici di trasformazioni omogenee
% -------------------------------------------------------------------------
% Stampa e restituisce in A le n matrici di trasformazioni omogenee
% degli n giunti secondo la convenzione di DH.
% Stampa e restituisce in T il prodotto tra le n matrici in A, quindi la
% matrice di trasformazione totale del manipolatore.
% -------------------------------------------------------------------------
% Formato di parameters: [ a | d | alpha | theta ]
% Esempio:
% syms q1 q2 q3
% parameters = [
%   0,      1,      0,      q1;
%   0,      q2,     pi/2,   pi/2;
%   0,      q3,     0,      0;
% ]
% -------------------------------------------------------------------------
% Dopo la chiamata, si possono recuperare le singole matrici.
% Esempio:
% [A, T] = DHmatrix(parameters);
% A01 = A(:,:,1);
% A12 = A(:,:,2);
% A23 = A(:,:,3);
% A02 = A01*A12;
% A03 = T;      oppure      A03 = A01*A12*A23;
% -------------------------------------------------------------------------

function [A, T] = DHmatrix(parameters)
    % Parametri a, d, alpha, theta
    a = parameters(:,1);
    d = parameters(:,2);
    alpha = parameters(:,3);
    theta = parameters(:,4);
    
    % Numero di giunti (e di matrici)
    n = size(parameters, 1);
    
    % Vettore di n matrici di trasformazione
    A = sym(zeros(4, 4, n));
    
    % Assegnazione e stampa delle n matrici di trasformazione
    for i = 1:n
        A(:,:,i) = [
            cos(theta(i)), -sin(theta(i))*cos(alpha(i)), sin(theta(i))*sin(alpha(i)), cos(theta(i))*a(i);
            sin(theta(i)), cos(theta(i))*cos(alpha(i)), -cos(theta(i))*sin(alpha(i)), sin(theta(i))*a(i);
            0, sin(alpha(i)), cos(alpha(i)), d(i);
            0, 0, 0, 1;
        ];
        A(:,:,i) = simplify(A(:,:,i));
        disp(['*** A' num2str(i-1) num2str(i) ' ***'])
        disp(A(:,:,i))
    end
    
    % Assegnazione e stampa della matrice di trasformazione totale (A0n)
    T = A(:,:,1);
    for i = 2:n
       T = simplify(T * A(:,:,i));
    end
    disp(['*** A0' num2str(n) ' ***'])
    disp(T)
    
end