df1 = CSV.read("JuliaResources/1stepbefore.csv", DataFrame)

f(r) = if r<0.33
    return "Healthy"
elseif r<0.66
    return "Unhealthy"
else
    return "Control"
end
df1.r_h = f.(df1.r)

files = df1[df1.r_h .== "Healthy", :file_name]

for file in files
    df = CSV.read("data/"*file, DataFrame)
    posh = df[df.conds_file .== "cong_test.xlsx", :rt]
    negh = df[df.conds_file .== "incong_test.xlsx", :rt]
    inclusive_std = std([posh; negh])
    df.rt += 0.3*inclusive_std*(df)
end

