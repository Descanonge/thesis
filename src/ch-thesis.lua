
local function addFeatKern ()
  fonts.handlers.otf.addfeature {
    name = "customkern",
    type = "kern",
    data = {
      ["a"] = { [")"] = -75 },
      ["one.Alt.tosf"] = {
        ["one.Alt.tosf"] = -75,
        ["three.tosf"] = -40,
        ["two.tosf"] = -40,
        ["five.tosf"] = -50,
        ["six.tosf"] = -40,
        ["eight.tosf"] = -45,
        ["nine.tosf"] = -35,
      },
      ["two.tosf"] = {
        ["one.Alt.tosf"] = -30,
      },
      ["three.tosf"] = {
        ["one.Alt.tosf"] = -25,
      },
      ["eight.tosf"] = {
        ["one.Alt.tosf"] = -20,
      },
    }
  }
end

return { addFeatKern = addFeatKern }
