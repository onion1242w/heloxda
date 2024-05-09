local developerProducts = game:GetService("MarketplaceService"):GetDeveloperProductsAsync():GetCurrentPage()

for _, developerProduct in pairs(developerProducts) do
    for field, value in pairs(developerProduct) do
        if field == "DeveloperProductId" or field == "ProductId" then -- I think it's just productid but whatever
            task.defer(function()
                game:GetService("MarketplaceService"):SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, value, true)
            end)
        end
    end
end
