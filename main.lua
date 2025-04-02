require "collision"

function love.load()
  math.randomseed(os.time())
  player = {}
  player.x = 50
  player.y = 300
  player.w = 85
  player.h = 100

  coins = {}
  score = 0
end

function love.update(dt)
  if love.keyboard.isDown("right") then
    player.x = player.x + 4
  elseif love.keyboard.isDown("left") then
    player.x = player.x - 4
  elseif love.keyboard.isDown("down") then
    player.y = player.y + 4
  elseif love.keyboard.isDown("up") then
    player.y = player.y - 4
  end

  for i= #coins, 1, -1 do
    local coin = coins[i]
    if AABB(player.x, player.y, player.w, player.h, coin.x, coin.y, coin.w, coin.h) then
      table.remove(coins, i)
      score = score + 1
    end
  end


  if math.random() < 0.01 then
    local coin = {}
    coin.w = 56
    coin.h = 56
    coin.x = math.random(0, 800 - coin.w)
    coin.y = math.random(0, 600 - coin.h)
    table.insert(coins, coin)
  end
end

function love.draw()
  love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
  for i=1, #coins, 1 do
    local coin = coins[i]
    love.graphics.rectangle("fill", coin.x, coin.y, coin.w, coin.h)
  end
  love.graphics.print("Scroe: " .. score, 10, 10)
end
