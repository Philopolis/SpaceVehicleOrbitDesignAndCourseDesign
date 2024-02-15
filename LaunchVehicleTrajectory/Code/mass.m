%% 质量函数
function m = mass(t)

% 火箭发动机参数
m_s1 = 20800/61.6;
m_s2 = 6250/65.2;
m_s3 = 3320/59.6;

if t < 61.6
    m = 35400 - m_s1 * t;
elseif t < 126.8
    m = 12720 - m_s2 * (t - 61.6);
elseif t < 186.4
    m = 5670 - m_s3 * (t - 126.8);
else
    m = 2020;
end
end

