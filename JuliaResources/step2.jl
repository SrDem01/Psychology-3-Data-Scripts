# go through each file and collect d_scores

using DataFrames, CSV, Statistics

files = filter(x -> occursin(".csv", x), readdir("./data/"))
files[1], files[2] = files[2], files[1]

n = length(files)

d_scores = zeros(n)

for i in 1:n
    df = CSV.read("data/"*files[i], DataFrame)
    df = df[1:70, [:participant, :conds_file, :rt, :corr]]

    # wrong penalty = 600 ms
    df.rt -= (df.corr.-1)*0.600

    posh = df[df.conds_file .== "cong_test.xlsx", :rt]
    negh = df[df.conds_file .== "incong_test.xlsx", :rt]

    m_posh = mean(posh)
    m_negh = mean(negh)

    inclusive_std = std([posh; negh])

    D = (m_negh - m_posh)/inclusive_std
    d_scores[i] = D
end

df = CSV.read("JuliaResources/f_base_mod.csv", DataFrame)
df.D = d_scores
df.file_name = files

CSV.write("./1stepbefore.csv", df)