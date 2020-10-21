function Jb = JacobianB(J0, Rb0)
    Jb = [Rb0 zeros(3,3); zeros(3,3) Rb0] * J0;
end