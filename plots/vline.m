function pp=vline(x, vec, curve)
[A,B] = max(vec);
ymin=0.5;
if length(B) == 1
    pp=plot([x(B),x(B)],[ymin,A],...
        'Color',curve.Color,...
        'LineWidth',2,...
        'LineStyle','--');
end
end