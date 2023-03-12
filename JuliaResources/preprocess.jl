using DataFrames, CSV, Statistics

df = CSV.read("JuliaResources/1stepbefore.csv", DataFrame)

food = Dict(
    "Mixed Fruit Bowl Meal" => 1,
    "Burger and Fries" => -1,
    "Double Toppings Pizza" => -1,
    "Pea and Beans Soup" => 1,
    "Greek Yogurt" => 1,
    "Onion Rings" => -1,
    "Cole Slaw" => 1,
    "Pretzels" => -1,
    "Ice Cream Smoothie" => -1,
    "Lemonade" => 1,
    "Cocacola" => -1,
    "Iced Water" => 1,
    missing => 0,
    "" => 0
)

# Come back later
# state = Dict(
# )
n = nrow(df)
for col in ["main", "side", "drink"]
    f(x) = food[x]
    df[:, col*"h"] = f.(df[:, col])
end

h_score = zeros(n)

for i in 1:n
    h_score[i] = sum(df[i, [:mainh, :sideh, :drinkh]])
end

df.h_score = h_score

#one hot encode for city
ux = unique(df.citytier); transform!(df, @. :citytier => ByRow(isequal(ux)) .=> Symbol(:dummy_, ux))

#treatment levels
f(r) = if r<0.33
    return "Healthy"
elseif r<0.66
    return "Unhealthy"
else
    return "Control"
end
df.r_h = f.(df.r)

ux = unique(df.r_h); transform!(df, @. :r_h => ByRow(isequal(ux)) .=> Symbol(:grp, ux))

g(x) = if x == "Female"
    return 1
else
    return 0
end

df.fem = g.(df.gender)

df.age1 = 2023 .- [parse(Int,x) for x in df[:,:age]]
df.glasses_of_water1 = [parse(Int,x) for x in df[:,:glasses_of_water]]

# version 1 (without state data)
dat = df[:, ["h_score", "grpControl", "grpHealthy", "grpUnhealthy", "age1", "glasses_of_water1", "fem1", "dummy_a city", "dummy_a town", "dummy_a village", "r_h", "citytier"]]

rename!(dat, Dict(
    "dummy_a village" => :"vil",
    "dummy_a town" => "town",
    "dummy_a city" => "city",
    "r_h" => "grp",
    "glasses_of_water1" => "water",
    "age1" => "age"
    "fem1" => "fem"
    )
)

# dat.cent_D = (dat.D .- mean(dat.D))./std(dat.D)
# dat.cent_H = (dat.h_score .- mean(dat.h_score))./std(dat.h_score)

CSV.write("processed_dat2.csv", dat)