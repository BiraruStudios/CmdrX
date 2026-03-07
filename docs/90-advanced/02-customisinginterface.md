# Customising the interface

When required on the server, CmdrX will automatically create and insert into StarterGui its console interface (called Window), unless a ScreenGui named `CmdrX` already exists in StarterGui.

When required on the client, CmdrX will check to see if `PlayerGui` includes a ScreenGui named `CmdrX`. If not, it'll create the Window and insert it into PlayerGui.

The CmdrX GUI will be inserted into StarterGui if it doesn't already exist. You can customize the GUI to your liking (changing colors, etc.) if you play the game, copy the GUI, stop the game, and then paste it in to StarterGui. Of course, this is completely optional.

You can also customise the CmdrX interface through `PlayerGui:WaitForChild("CmdrX")` and then making changes from there.

:::caution Updating

If we make an update that changes the CmdrX interface, then this might break your customisations. You'll then need to take manual action when updating.

We recommend against disabling any auto-update features (e.g. pinning your CmdrX version on Wally), but this will require you to be vigilant of new releases.

:::

## Duplicate ScreenGui

You should note that **if you have CharacterAutoLoads set to false** and you load CmdrXClient before StarterGui loads (which is on the first character spawn) then you will end up with two CmdrX ScreenGuis. This normally is not an issue, but if you're also customising the CmdrX interface by hooking into `PlayerGui.CmdrX` then this could be problematic.

You can mitigate this issue by refraining from requiring CmdrXClient until after PlayerGui has loaded, but this will create a delay in users being able to access CmdrX until after their character has spawned for the first time.

Alternatively, you could:

1. Delete `CmdrX` from `StarterGui` on the server, after you've required the CmdrX server
2. On the client, load your modified copy of CmdrX ScreenGui into PlayerGui (you can skip this step if you only want the default ScreenGui)
3. And then, once you've inserted the gui, require CmdrXClient
