# Move this folder into `ikamet-os-core` (one time)

**This does not belong in `web-analytics`.** Copy it into your core repo and commit there.

## On your Mac (one time)

```bash
cp -a ~/GitHub/web-analytics/TRANSFER-TO-ikamet-os-core/cursor ~/GitHub/ikamet-os-core/cursor
bash ~/GitHub/ikamet-os-core/cursor/install.sh
```

Then in `ikamet-os-core`:

```bash
cd ~/GitHub/ikamet-os-core
git add cursor
git commit -m "Add Cursor workspace installer for all Ikamet repos"
git push
```

Then delete this transfer folder from `web-analytics` (or ignore — it should not stay long term).

## After that — every day

Double-click `~/GitHub/Open Ikamet in Cursor.command`  
or open `~/GitHub/ikamet.code-workspace` in Cursor.

**Never search web-analytics for ecosystem setup again.**
