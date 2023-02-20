using CSV
using DataFrames

df = CSV.read("created-datasets/southeast.csv", DataFrame)

function convert_lnglat(x)
    tup = split(x, ",")
    tup2 = replace.(tup, "[" => "")
    tup3 = replace.(tup2, "]" => "")
    return parse.(Float64, tup3)
end

lnglat = zeros(size(df,1), 2);
for i in 1:size(df, 1)
    println(i)
    lnglat[i,:] = convert_lnglat(df[:lnglat][i])
end
df[:lnglat][676]