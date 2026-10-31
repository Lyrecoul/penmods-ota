# PenMods OTA

从 v2.7.0 起，`updates.json` 同时保留旧客户端的 `versions` 和新版更新中心的 `components`，不得删除历史版本或移动已发布标签。

- `update_v2.7.0.zip` 是旧客户端与首次手动安装的完整迁移包：安装独立启动器、快照当前库、暂存内层 core，然后安装启动入口；不覆盖正在运行的主库。
- `core_v2.7.0.zip` 是新版更新中心使用的数据包，包含同一版本的主库与资源库。`components/core` 必须指向此包，旧版 `versions` 必须指向完整迁移包。
- 扩展使用独立版本和依赖范围，清单中的下载地址位于对应 PenMods Release；MathJax 包超过 jsDelivr 单文件限制，必须使用 Release 下载地址。
- `template/` 保存完整迁移包输入；两份裸库仅保留作发布输入记录，当前安装脚本不再直接替换它们。请勿按旧模板重新打包。

版本与制作工具见 [PenMods 更新系统说明](https://github.com/Lyrecoul/PenMods/blob/V2.7.0/doc/UPDATE_SYSTEM.md)，安装与附件见 [V2.7.0 Release](https://github.com/Lyrecoul/PenMods/releases/tag/V2.7.0)。
