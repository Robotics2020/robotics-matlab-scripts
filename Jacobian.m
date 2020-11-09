function J = Jacobian(A, T, Ae, Jtypes)

    joints = Jtypes{1};
    n = length(joints);
    J = sym(zeros(6, n));
    
    for i = 1:n
        if i == 1
            zi = [0 0 1]';
        else
            A0i = A(:,:,1);
            for j = 2 : i - 1
                A0i = simplify(A0i * A(:,:,j));
            end
            zi = A0i(1:3, 3);
        end
        joint = joints(i);
        if joint == 'R'
            A0e = T * Ae;
            pe = A0e(1:3, 4);
            A0i = simplify(A0i * A(:,:,i));
            p_i = A0i(1:3, 4);
            J(:,i) = [cross(zi, pe - p_i); zi];
        elseif joint == 'P'
            J(:,i) = [zi; zeros(3,1)];
        else
            error('Wrong joint types!');
        end
    end

end