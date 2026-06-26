## Summary
<!-- What does this PR add, fix, or change? One or two sentences. -->

## Type
- [ ] Bug fix
- [ ] New module / function
- [ ] Breaking change
- [ ] Documentation
- [ ] Other

## Module(s) Affected
<!-- e.g. scheduler/, dialog/, math/uuid -->

## Testing
<!-- How was this tested? Which MC version / pack_format? -->
- Minecraft version:
- pack_format:

## Checklist
- [ ] Functions are commented with module path and context (`# @context`)
- [ ] No hardcoded player selectors where macro input is expected
- [ ] `pack.mcmeta` `supported_formats` uses object syntax (not array)
- [ ] `min_format` / `max_format` present and consistent with `formats` ranges
- [ ] Overlay `formats` ranges do not overlap
- [ ] Overlay added if version-specific behavior changed

## Related Issues
<!-- Closes # -->
