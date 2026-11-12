# Syok Code in your own GitHub Codespace

This template gives you a ready-made GitHub Codespace (a small computer in the cloud) that **Syok Code** can use to run commands for you: install packages, run tests, build your project.

It runs on **your** GitHub account, so it uses your own free Codespaces hours. Syok pays nothing and never sees your GitHub password.

## Set it up (about 5 minutes)

1. Click the green **Use this template** button, then **Create a new repository**. Name it anything you like. A private repository is fine.
2. In your new repository click **Code**, then the **Codespaces** tab, then **Create codespace on main**. Wait until the terminal appears (the first build can take several minutes, up to about 10, while GitHub prepares it). If it asks "Do you trust the authors?" or shows Restricted Mode, click Trust Folder and Continue, otherwise the terminal will not work. The link to Syok starts by itself, even when Syok wakes a stopped Codespace and you never open it.
3. In Syok open **Code**, then **Connect**, then **Codespace**, and press **Get pairing code**. Syok shows one command to copy.
4. Paste that command into the Codespace terminal and press Enter. You should see `Paired`.

That is all. Syok Code can now run commands in this Codespace.

## Good to know

- **Your code stays in your Codespace.** Syok only receives what the commands print.
- **Only Syok can use the link.** It is protected by a long secret that is made inside your Codespace. To cut the link at any time, run `syok unpair` in the Codespace and press **Unlink** in Syok.
- **Codespaces sleep after about 30 minutes of nothing happening.** Syok can start it again for you if you allow it in Syok (this needs a GitHub token with Codespaces permission that you create yourself).
- **Your organisation may block this.** The link needs port 8787 to be public. If your company or school account forbids public ports, the link cannot work there. Use your personal GitHub account instead.
- **Check it any time** with `syok bridge status`.
