# TradingView Flutter Changelog


## [0.0.1] 

### Added
- 初始版本发布，集成了 TradingView 高级图表功能。
- 支持明亮（Light）和黑暗（Dark）主题模式。
- 提供多语言（Locale）配置选项。
- 实现了基于 `WebView` 的高性能图表渲染。
- 引入 `TradingViewData` 配置类，用于灵活定制图表参数，包括 `symbol`（交易品种）、`interval`（时间间隔）、`timezone`（时区）等。
- 提供了 `TradingViewWidget` 组件，方便在 Flutter 应用中嵌入图表。
- 包含了 `TradingViewEmbedder` 和 `TradingViewJsInteropt`，用于处理 WebView 逻辑和 JavaScript 交互。

## [0.0.2]

### Changed
- 详细说明 `lib` 目录结构和功能
`TradingViewWidget` 组件、`TradingViewEmbedder` 和 `TradingViewJsInteropt` 的详细说明和使用示例


## [0.0.3]

### Changed
- 详细说明 `lib` 目录结构和功能
`TradingViewWidget` 组件、`TradingViewEmbedder` 和 `TradingViewJsInteropt` 的详细说明和使用示例


## [0.0.4]

### Added
- 添加文档

### Changed
- 详细说明 `lib` 目录结构和功能
`TradingViewWidget` 组件、`TradingViewEmbedder` 和 `TradingViewJsInteropt` 的详细说明和使用示例


## [0.0.5]

### Added
- 添加轻量级图表支持 (`TradingViewLightChart` 组件)
- 新增 `web_initializer.dart` 用于 Flutter Web 平台初始化
- 新增 `trading_view_calculation.dart` 包含成交量计算工具

### Changed
- 更新轻量级图表库版本至 4.2.1
- 优化主题解析扩展 (`trading_view_theme.dart`)
- 改进 `TradingViewData` 类的 JSON 序列化

### Fixed
- 修复 Web 平台初始化问题


## [0.0.6]

### Added
- 新增自定义指标支持 (`ChartIndicator` 模型类)
- 新增成交量数据模型 (`ChartVolume` 类)
- 新增图片标记模型 (`ChartIndicatorImage` 类)
- 新增图表指示器类型枚举 (`ChartIndicatorType`，包含24种类型)
- 新增指标形状枚举 (`IndicatorShape`，包含5种形状)
- 扩展 `TradingViewData` 类，新增 `indicators`、`volume` 和 `indicatorImages` 字段
- 新增 `date_formatter.dart` 扩展用于日期格式化

### Changed
- 更新 `trading_view_flutter.dart` 导出文件，包含所有新增模型类
- 优化项目结构，在 `lib/src/model/` 目录下组织所有数据模型
- 改进 README 文档，添加新增功能的详细说明

### Fixed
- 修复未使用的导入警告
- 改进代码分析和包验证


