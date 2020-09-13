function dist = my_dtw(x,y) ;
[n p] = size(x) ;
[m p] = size(y) ; 
Cst = zeros(n,m) ; 
dp = Cst ; 

for i = 1:n
    for j = 1:m
        for k = 1:13
            Cst(i,j) = Cst(i,j) + ( x(i,k)-y(j,k) )*( x(i,k)-y(j,k) ) ; 
        end
        Cst(i,j) = sqrt(Cst(i,j)) ;
    end
end

dp(1,1) = Cst(1,1) ;
for i = 2:n
    dp(i,1) = dp(i-1,1) + Cst(i,1) ;
end
for j = 2:m
    dp(1,j) = dp(1,j-1) + Cst(1,j) ; 
end

for i = 2:n
    for j = 2:m
        dp(i,j) = min(dp(i-1,j-1),dp(i-1,j)) ; 
        dp(i,j) = min(dp(i,j),dp(i,j-1)) ; 
        dp(i,j) = dp(i,j) + Cst(i,j) ; 
    end
end

dist = dp(n,m) ; 