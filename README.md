<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>罗老师开奖查询系统 - AI增强版</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Microsoft YaHei', Arial, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: white;
            text-shadow: 0 2px 5px rgba(0,0,0,0.3);
        }
        
        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        .countdown-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 25px;
            margin-bottom: 25px;
            text-align: center;
        }
        
        .countdown-title {
            color: #1a2a6c;
            font-size: 1.5rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .countdown-title i {
            margin-right: 10px;
            color: #b21f1f;
        }
        
        .countdown-info {
            display: flex;
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        
        .current-period {
            font-size: 1.3rem;
            font-weight: bold;
            color: #1a2a6c;
        }
        
        .next-draw-time {
            font-size: 1.1rem;
            color: #b21f1f;
        }
        
        .countdown-timer {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 15px;
        }
        
        .countdown-unit {
            background: linear-gradient(to bottom, #1a2a6c, #0d1a4d);
            color: white;
            padding: 15px;
            border-radius: 10px;
            min-width: 80px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .countdown-value {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .countdown-label {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        .card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 25px;
            margin-bottom: 25px;
            transition: transform 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card h2 {
            color: #1a2a6c;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #fdbb2d;
            display: flex;
            align-items: center;
        }
        
        .card h2 i {
            margin-right: 10px;
            color: #b21f1f;
        }
        
        .controls {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        button {
            background: linear-gradient(to right, #1a2a6c, #b21f1f);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 50px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        button i {
            margin-right: 8px;
        }
        
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.3);
        }
        
        button:active {
            transform: translateY(1px);
        }
        
        button:disabled {
            background: #cccccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .year-input, .count-input, .periods-input, .ai-periods-input {
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 50px;
            font-size: 1rem;
            width: 150px;
            transition: border-color 0.3s;
        }
        
        .year-input:focus, .count-input:focus, .periods-input:focus, .ai-periods-input:focus {
            border-color: #1a2a6c;
            outline: none;
        }
        
        .result-container {
            margin-top: 20px;
            display: none;
        }
        
        .result-item {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            border-left: 5px solid #1a2a6c;
        }
        
        .result-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }
        
        .expect {
            font-size: 1.3rem;
            font-weight: bold;
            color: #1a2a6c;
        }
        
        .open-time {
            color: #666;
            font-size: 0.9rem;
        }
        
        .numbers {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 15px;
        }
        
        .number {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
            color: white;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        
        .number-zodiac {
            font-size: 0.7rem;
            margin-top: 2px;
        }
        
        .number-element {
            font-size: 0.6rem;
            margin-top: 1px;
            opacity: 0.9;
        }
        
        .wave {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 15px;
        }
        
        .wave-item {
            padding: 5px 15px;
            border-radius: 20px;
            color: white;
            font-weight: bold;
            font-size: 0.9rem;
        }
        
        .zodiac {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .zodiac-item {
            padding: 5px 15px;
            border-radius: 20px;
            background: #f5f5f5;
            font-weight: bold;
            font-size: 0.9rem;
            border: 1px solid #ddd;
        }
        
        .loading {
            text-align: center;
            padding: 30px;
            display: none;
        }
        
        .spinner {
            border: 5px solid #f3f3f3;
            border-top: 5px solid #1a2a6c;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 0 auto 15px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .error {
            background: #ffecec;
            color: #b21f1f;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
            display: none;
            border-left: 5px solid #b21f1f;
        }
        
        .success {
            background: #ecf9ec;
            color: #2a6c2a;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
            display: none;
            border-left: 5px solid #2a6c2a;
        }
        
        .debug-info {
            background: #f0f8ff;
            color: #1a2a6c;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
            display: none;
            border-left: 5px solid #1a2a6c;
            font-family: monospace;
            font-size: 0.9rem;
            white-space: pre-wrap;
        }
        
        /* 新版生肖对照表样式 */
        .zodiac-grid, .element-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 15px;
            margin-top: 15px;
        }
        
        .zodiac-column, .element-column {
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .zodiac-header, .element-header {
            background: linear-gradient(135deg, #1a2a6c, #b21f1f);
            color: white;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 10px;
            font-weight: bold;
            font-size: 1.1rem;
        }
        
        .zodiac-number, .element-number {
            padding: 5px;
            margin: 3px 0;
            background: #f8f9fa;
            border-radius: 5px;
            font-weight: bold;
            color: #1a2a6c;
            border: 1px solid #e9ecef;
        }
        
        /* 走势图样式 */
        .trend-controls, .ai-controls {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
            align-items: center;
        }
        
        .trend-results {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .trend-section {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .trend-section h3 {
            color: #1a2a6c;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #fdbb2d;
        }
        
        .trend-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .trend-item:last-child {
            border-bottom: none;
        }
        
        .trend-name {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .trend-count {
            font-weight: bold;
            color: #1a2a6c;
        }
        
        .trend-bar {
            flex-grow: 1;
            height: 20px;
            background: #f0f0f0;
            border-radius: 10px;
            margin: 0 15px;
            overflow: hidden;
        }
        
        .trend-bar-fill {
            height: 100%;
            background: linear-gradient(to right, #1a2a6c, #b21f1f);
            border-radius: 10px;
            transition: width 0.5s ease;
        }
        
        /* AI分析样式 */
        .analysis-report {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-top: 15px;
        }
        
        .report-header {
            border-bottom: 2px solid #fdbb2d;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        
        .report-meta {
            display: flex;
            justify-content: space-between;
            color: #666;
            font-size: 0.9rem;
        }
        
        .analysis-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .analysis-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            border-left: 4px solid #1a2a6c;
        }
        
        .analysis-card h4 {
            color: #1a2a6c;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .analysis-card h4 i {
            margin-right: 8px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        
        .stat-item {
            text-align: center;
            padding: 10px;
            background: white;
            border-radius: 8px;
        }
        
        .stat-label {
            font-size: 0.8rem;
            color: #666;
            margin-bottom: 5px;
        }
        
        .stat-value {
            font-size: 1.2rem;
            font-weight: bold;
            color: #1a2a6c;
        }
        
        .pattern-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .pattern-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .pattern-value {
            font-weight: bold;
            color: #1a2a6c;
        }
        
        .prediction-card {
            background: linear-gradient(135deg, #1a2a6c, #b21f1f);
            color: white;
        }
        
        .prediction-card h4 {
            color: white;
        }
        
        .prediction-numbers {
            display: flex;
            gap: 10px;
            margin: 15px 0;
            justify-content: center;
        }
        
        .prediction-number {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.1rem;
            backdrop-filter: blur(10px);
        }
        
        .prediction-info {
            text-align: center;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .hot-numbers {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 8px;
        }
        
        .hot-number {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 8px;
            background: white;
            border-radius: 6px;
            font-size: 0.8rem;
        }
        
        .hot-number .number {
            font-weight: bold;
            color: #1a2a6c;
        }
        
        .hot-number .count {
            color: #666;
            font-size: 0.7rem;
        }
        
        .warning-card {
            background: #fff3cd;
            border-left-color: #ffc107;
        }
        
        .warning-card h4 {
            color: #856404;
        }
        
        .warnings {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .warning-item {
            padding: 8px 12px;
            background: white;
            border-radius: 6px;
            font-size: 0.8rem;
            color: #856404;
            border-left: 3px solid #ffc107;
        }
        
        /* 数据库管理样式 */
        .db-info-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .db-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }
        
        .db-stat {
            text-align: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .db-stat-value {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1a2a6c;
            margin: 5px 0;
        }
        
        .db-stat-label {
            color: #666;
            font-size: 0.9rem;
        }
        
        .db-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }
        
        /* AI预测历史记录样式 */
        .prediction-history {
            margin-top: 20px;
        }
        
        .history-item {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            border-left: 4px solid #1a2a6c;
        }
        
        .history-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        .history-predictions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 10px;
        }
        
        .history-prediction {
            padding: 5px 10px;
            background: #f8f9fa;
            border-radius: 5px;
            font-size: 0.9rem;
        }
        
        .history-result {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .correct {
            color: #2a6c2a;
            font-weight: bold;
        }
        
        .incorrect {
            color: #b21f1f;
            font-weight: bold;
        }
        
        .footer {
            text-align: center;
            margin-top: 30px;
            color: white;
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        @media (max-width: 768px) {
            .controls, .trend-controls, .ai-controls {
                flex-direction: column;
            }
            
            button {
                width: 100%;
            }
            
            .year-input, .count-input, .periods-input, .ai-periods-input {
                width: 100%;
            }
            
            .result-header {
                flex-direction: column;
            }
            
            .expect {
                margin-bottom: 5px;
            }
            
            .number {
                width: 60px;
                height: 60px;
                font-size: 1rem;
            }
            
            .number-zodiac, .number-element {
                font-size: 0.5rem;
            }
            
            .countdown-timer {
                gap: 10px;
            }
            
            .countdown-unit {
                min-width: 70px;
                padding: 10px;
            }
            
            .countdown-value {
                font-size: 1.5rem;
            }
            
            .trend-results {
                grid-template-columns: 1fr;
            }
            
            .zodiac-grid, .element-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
            }
            
            .zodiac-column, .element-column {
                padding: 10px;
            }
            
            .zodiac-header, .element-header {
                font-size: 1rem;
                padding: 8px;
            }
            
            .analysis-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .hot-numbers {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .prediction-numbers {
                flex-wrap: wrap;
            }
            
            .db-stats {
                grid-template-columns: 1fr 1fr;
            }
        }
        
        @media (max-width: 480px) {
            .zodiac-grid, .element-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .db-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>罗傲开奖查询系统 - AI增强版</h1>
            <p>实时获取最新开奖结果和历史数据 | 内置智能AI分析和深度学习预测</p>
        </div>
        
        <!-- 倒计时区域 -->
        <div class="countdown-section">
            <div class="countdown-title">
                <i>⏰</i> 下一期开奖倒计时
            </div>
            <div class="countdown-info">
                <div class="current-period" id="currentPeriod">第 2025292 期</div>
                <div class="next-draw-time" id="nextDrawTime">2025-10-19 21:34:00 星期日</div>
            </div>
            <div class="countdown-timer">
                <div class="countdown-unit">
                    <div class="countdown-value" id="countdownHours">00</div>
                    <div class="countdown-label">小时</div>
                </div>
                <div class="countdown-unit">
                    <div class="countdown-value" id="countdownMinutes">00</div>
                    <div class="countdown-label">分钟</div>
                </div>
                <div class="countdown-unit">
                    <div class="countdown-value" id="countdownSeconds">00</div>
                    <div class="countdown-label">秒</div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <h2><i>📡</i> API数据查询</h2>
            <div class="controls">
                <button id="latestBtn"><i>🔍</i> 查询最新开奖</button>
                <button id="liveBtn"><i>📺</i> 查询实时开奖</button>
                <div style="display: flex; gap: 10px; align-items: center;">
                    <input type="number" id="yearInput" class="year-input" placeholder="输入年份" min="2020" max="2030" value="2025">
                    <input type="number" id="countInput" class="count-input" placeholder="查询期数" min="1" max="100" value="10">
                    <button id="historyBtn"><i>📚</i> 查询历史数据</button>
                </div>
                <button id="trendBtn"><i>📊</i> 走势图分析</button>
                <button id="saveToDbBtn"><i>💾</i> 保存到数据库</button>
                <button id="analyzeWithAIBtn"><i>🤖</i> AI智能分析</button>
                <button id="dbManageBtn"><i>🗃️</i> 数据库管理</button>
                <button id="debugBtn"><i>🐛</i> 调试模式</button>
            </div>
            
            <div id="loading" class="loading">
                <div class="spinner"></div>
                <p>正在查询数据，请稍候...</p>
            </div>
            
            <div id="error" class="error">
                <p id="errorMsg"></p>
            </div>
            
            <div id="success" class="success">
                <p id="successMsg"></p>
            </div>
            
            <div id="debugInfo" class="debug-info">
                <p id="debugMsg"></p>
            </div>
            
            <div id="resultContainer" class="result-container">
                <!-- 结果将在这里显示 -->
            </div>
        </div>
        
        <!-- AI分析结果区域 -->
        <div class="card" id="aiAnalysisSection" style="display: none;">
            <h2><i>🤖</i> DeepSeek AI 智能分析报告</h2>
            <div class="ai-controls">
                <input type="number" id="aiPeriodsInput" class="ai-periods-input" placeholder="分析期数" min="1" max="500" value="10">
                <button id="analyzeWithAIBtn2"><i>🤖</i> 执行AI分析</button>
                <button id="closeAIBtn"><i>❌</i> 关闭分析</button>
            </div>
            <div id="aiAnalysisResults">
                <!-- AI分析结果将在这里显示 -->
            </div>
        </div>
        
        <!-- AI预测历史记录区域 -->
        <div class="card" id="aiHistorySection" style="display: none;">
            <h2><i>📝</i> AI预测历史记录</h2>
            <div class="db-actions">
                <button onclick="clearPredictionHistory()" style="background: linear-gradient(to right, #b21f1f, #ff6b6b);"><i>🗑️</i> 清空历史记录</button>
            </div>
            <div id="aiHistoryResults" class="prediction-history">
                <!-- AI预测历史记录将在这里显示 -->
            </div>
        </div>
        
        <!-- 数据库管理区域 -->
        <div class="card" id="dbManageSection" style="display: none;">
            <h2><i>🗃️</i> 数据库管理</h2>
            <div id="dbManageResults">
                <!-- 数据库管理界面将在这里显示 -->
            </div>
        </div>
        
        <!-- 走势图分析区域 -->
        <div class="card" id="trendAnalysis" style="display: none;">
            <h2><i>📊</i> 走势图分析</h2>
            <div class="trend-controls">
                <input type="number" id="periodsInput" class="periods-input" placeholder="分析期数" min="10" max="500" value="100">
                <button id="analyzeTrendBtn"><i>📈</i> 分析特码走势</button>
                <button id="closeTrendBtn"><i>❌</i> 关闭分析</button>
            </div>
            
            <div id="trendResults" class="trend-results">
                <!-- 走势分析结果将在这里显示 -->
            </div>
        </div>
        
        <div class="card">
            <h2><i>🐭</i> 生肖号码对照表</h2>
            <div class="zodiac-grid" id="zodiacGrid">
                <!-- 生肖数据将通过JavaScript填充 -->
            </div>
        </div>
        
        <div class="card">
            <h2><i>🌿</i> 五行号码对照表</h2>
            <div class="element-grid" id="elementGrid">
                <!-- 五行数据将通过JavaScript填充 -->
            </div>
        </div>
        
        <div class="footer">
            <p>© 2025 罗老师系统 - 本系统仅用于导管使用</p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 获取DOM元素
            const latestBtn = document.getElementById('latestBtn');
            const liveBtn = document.getElementById('liveBtn');
            const historyBtn = document.getElementById('historyBtn');
            const trendBtn = document.getElementById('trendBtn');
            const saveToDbBtn = document.getElementById('saveToDbBtn');
            const analyzeWithAIBtn = document.getElementById('analyzeWithAIBtn');
            const analyzeWithAIBtn2 = document.getElementById('analyzeWithAIBtn2');
            const dbManageBtn = document.getElementById('dbManageBtn');
            const debugBtn = document.getElementById('debugBtn');
            const analyzeTrendBtn = document.getElementById('analyzeTrendBtn');
            const closeTrendBtn = document.getElementById('closeTrendBtn');
            const closeAIBtn = document.getElementById('closeAIBtn');
            const yearInput = document.getElementById('yearInput');
            const countInput = document.getElementById('countInput');
            const periodsInput = document.getElementById('periodsInput');
            const aiPeriodsInput = document.getElementById('aiPeriodsInput');
            const loading = document.getElementById('loading');
            const error = document.getElementById('error');
            const success = document.getElementById('success');
            const debugInfo = document.getElementById('debugInfo');
            const resultContainer = document.getElementById('resultContainer');
            const trendAnalysis = document.getElementById('trendAnalysis');
            const trendResults = document.getElementById('trendResults');
            const zodiacGrid = document.getElementById('zodiacGrid');
            const elementGrid = document.getElementById('elementGrid');
            const errorMsg = document.getElementById('errorMsg');
            const successMsg = document.getElementById('successMsg');
            const debugMsg = document.getElementById('debugMsg');
            const aiAnalysisSection = document.getElementById('aiAnalysisSection');
            const aiAnalysisResults = document.getElementById('aiAnalysisResults');
            const aiHistorySection = document.getElementById('aiHistorySection');
            const aiHistoryResults = document.getElementById('aiHistoryResults');
            const dbManageSection = document.getElementById('dbManageSection');
            const dbManageResults = document.getElementById('dbManageResults');
            
            // 倒计时元素
            const currentPeriod = document.getElementById('currentPeriod');
            const nextDrawTime = document.getElementById('nextDrawTime');
            const countdownHours = document.getElementById('countdownHours');
            const countdownMinutes = document.getElementById('countdownMinutes');
            const countdownSeconds = document.getElementById('countdownSeconds');
            
            // 系统变量
            let debugMode = false;
            let historyData = []; // 存储历史数据
            
            // 本地数据库
            let localDatabase = {
                history: [],
                analysis: {},
                predictions: [],
                version: '2.0',
                lastUpdate: ''
            };
            
            // 生肖号码对照数据
            const zodiacNumbers = {
                "鼠": [6, 18, 30, 42],
                "牛": [5, 17, 29, 41],
                "虎": [4, 16, 28, 40],
                "兔": [3, 15, 27, 39],
                "龙": [2, 14, 26, 38],
                "蛇": [1, 13, 25, 37, 49],
                "马": [12, 24, 36, 48],
                "羊": [11, 23, 35, 47],
                "猴": [10, 22, 34, 46],
                "鸡": [9, 21, 33, 45],
                "狗": [8, 20, 32, 44],
                "猪": [7, 19, 31, 43]
            };
            
            // 五行号码对照数据
            const elementNumbers = {
                "金": [3, 4, 11, 12, 25, 26, 33, 34, 41, 42],
                "木": [7, 8, 15, 16, 23, 24, 37, 38, 45, 46],
                "水": [13, 14, 21, 22, 29, 30, 43, 44],
                "火": [1, 2, 9, 10, 17, 18, 31, 32, 39, 40, 47, 48],
                "土": [5, 6, 19, 20, 27, 28, 35, 36, 49]
            };
            
            // 初始化系统
            initSystem();
            
            function initSystem() {
                loadLocalDatabase();
                initZodiacGrid();
                initElementGrid();
                initCountdown();
                bindEventListeners();
                showSuccess('系统初始化完成！本地数据库记录: ' + localDatabase.history.length + ' 条');
            }
            
            function loadLocalDatabase() {
                try {
                    const savedDb = localStorage.getItem('lotteryDatabase');
                    if (savedDb) {
                        localDatabase = JSON.parse(savedDb);
                        if (!localDatabase.predictions) {
                            localDatabase.predictions = [];
                        }
                    }
                } catch (e) {
                    console.log('初始化新数据库');
                    localDatabase = {
                        history: [],
                        analysis: {},
                        predictions: [],
                        version: '2.0',
                        lastUpdate: ''
                    };
                }
            }
            
            function bindEventListeners() {
                latestBtn.addEventListener('click', fetchLatestResults);
                liveBtn.addEventListener('click', fetchLiveResults);
                historyBtn.addEventListener('click', handleHistoryQuery);
                trendBtn.addEventListener('click', showTrendAnalysis);
                analyzeTrendBtn.addEventListener('click', handleTrendAnalysis);
                closeTrendBtn.addEventListener('click', hideTrendAnalysis);
                debugBtn.addEventListener('click', toggleDebugMode);
                saveToDbBtn.addEventListener('click', saveToLocalDatabase);
                analyzeWithAIBtn.addEventListener('click', showAIAnalysis);
                analyzeWithAIBtn2.addEventListener('click', handleAIAnalysis);
                closeAIBtn.addEventListener('click', hideAIAnalysis);
                dbManageBtn.addEventListener('click', showDatabaseManager);
            }
            
            function handleHistoryQuery() {
                const year = yearInput.value;
                const count = countInput.value;
                
                if (!year) {
                    showError('请输入要查询的年份');
                    return;
                }
                
                if (!count || count < 1) {
                    showError('请输入要查询的期数');
                    return;
                }
                
                fetchHistoryResults(year, count);
            }
            
            function handleTrendAnalysis() {
                const periods = periodsInput.value;
                if (!periods || periods < 10) {
                    showError('请输入至少10期的分析期数');
                    return;
                }
                analyzeTrend(parseInt(periods));
            }
            
            function handleAIAnalysis() {
                const periods = aiPeriodsInput.value;
                if (!periods || periods < 1) {
                    showError('请输入分析期数');
                    return;
                }
                performAIAnalysis(parseInt(periods));
            }
            
            function showAIAnalysis() {
                aiAnalysisSection.style.display = 'block';
                aiHistorySection.style.display = 'block';
                resultContainer.style.display = 'none';
                trendAnalysis.style.display = 'none';
                dbManageSection.style.display = 'none';
                displayPredictionHistory();
            }
            
            function hideAIAnalysis() {
                aiAnalysisSection.style.display = 'none';
                aiHistorySection.style.display = 'none';
            }
            
            function showTrendAnalysis() {
                trendAnalysis.style.display = 'block';
                resultContainer.style.display = 'none';
                aiAnalysisSection.style.display = 'none';
                aiHistorySection.style.display = 'none';
                dbManageSection.style.display = 'none';
            }
            
            function hideTrendAnalysis() {
                trendAnalysis.style.display = 'none';
            }
            
            function showDatabaseManager() {
                dbManageSection.style.display = 'block';
                resultContainer.style.display = 'none';
                aiAnalysisSection.style.display = 'none';
                aiHistorySection.style.display = 'none';
                trendAnalysis.style.display = 'none';
                displayDatabaseManager();
            }
            
            // 显示数据库管理界面
            function displayDatabaseManager() {
                const dbInfo = getDatabaseInfo();
                
                dbManageResults.innerHTML = `
                    <div class="db-info-card">
                        <h3>数据库信息</h3>
                        <div class="db-stats">
                            <div class="db-stat">
                                <div class="db-stat-label">总记录数</div>
                                <div class="db-stat-value">${dbInfo.totalRecords}</div>
                            </div>
                            <div class="db-stat">
                                <div class="db-stat-label">数据范围</div>
                                <div class="db-stat-value">${dbInfo.dataRange.start} 至 ${dbInfo.dataRange.end}</div>
                            </div>
                            <div class="db-stat">
                                <div class="db-stat-label">最后更新</div>
                                <div class="db-stat-value">${dbInfo.lastUpdate}</div>
                            </div>
                            <div class="db-stat">
                                <div class="db-stat-label">预测记录</div>
                                <div class="db-stat-value">${dbInfo.predictionRecords}</div>
                            </div>
                        </div>
                        
                        <div class="db-actions">
                            <button onclick="exportDatabase()"><i>📤</i> 导出数据</button>
                            <button onclick="clearDatabase()" style="background: linear-gradient(to right, #b21f1f, #ff6b6b);"><i>🗑️</i> 清空数据库</button>
                            <button onclick="refreshDbInfo()"><i>🔄</i> 刷新信息</button>
                        </div>
                    </div>
                    
                    <div class="db-info-card">
                        <h3>数据统计</h3>
                        <div id="dbStatsDetails">
                            <!-- 详细统计信息将在这里显示 -->
                        </div>
                    </div>
                `;
                
                displayDatabaseStats();
            }
            
            function getDatabaseInfo() {
                return {
                    totalRecords: localDatabase.history.length,
                    dataRange: localDatabase.history.length > 0 ? {
                        start: localDatabase.history[localDatabase.history.length - 1].openTime.split(' ')[0],
                        end: localDatabase.history[0].openTime.split(' ')[0]
                    } : { start: '无数据', end: '无数据' },
                    lastUpdate: localDatabase.lastUpdate ? new Date(localDatabase.lastUpdate).toLocaleString() : '从未更新',
                    predictionRecords: localDatabase.predictions.length
                };
            }
            
            function displayDatabaseStats() {
                const statsDetails = document.getElementById('dbStatsDetails');
                if (localDatabase.history.length === 0) {
                    statsDetails.innerHTML = '<p>数据库中没有数据</p>';
                    return;
                }
                
                const years = {};
                localDatabase.history.forEach(item => {
                    const year = item.expect.substring(0, 4);
                    years[year] = (years[year] || 0) + 1;
                });
                
                let statsHTML = '<div class="pattern-list">';
                Object.entries(years).forEach(([year, count]) => {
                    statsHTML += `
                        <div class="pattern-item">
                            <span>${year}年</span>
                            <span class="pattern-value">${count} 期</span>
                        </div>
                    `;
                });
                statsHTML += '</div>';
                
                statsDetails.innerHTML = statsHTML;
            }
            
            // 导出数据库
            function exportDatabase() {
                if (localDatabase.history.length === 0) {
                    showError('数据库中没有数据可导出');
                    return;
                }
                
                let exportContent = "期数\t开奖号码\t开奖时间\n";
                exportContent += "================================\n";
                
                localDatabase.history.forEach(item => {
                    exportContent += `${item.expect}\t${item.openCode}\t${item.openTime}\n`;
                });
                
                const dataBlob = new Blob([exportContent], {type: 'text/plain;charset=utf-8'});
                
                const link = document.createElement('a');
                link.href = URL.createObjectURL(dataBlob);
                link.download = `lottery_data_${new Date().toISOString().split('T')[0]}.txt`;
                link.click();
                
                showSuccess('数据导出成功！');
            }
            
            // 清空数据库
            function clearDatabase() {
                if (confirm('确定要清空数据库吗？此操作不可恢复！')) {
                    localDatabase = {
                        history: [],
                        analysis: {},
                        predictions: [],
                        version: '2.0',
                        lastUpdate: new Date().toISOString()
                    };
                    localStorage.setItem('lotteryDatabase', JSON.stringify(localDatabase));
                    showDatabaseManager();
                    showSuccess('数据库已清空！');
                }
            }
            
            // 清空预测历史记录
            function clearPredictionHistory() {
                if (confirm('确定要清空AI预测历史记录吗？此操作不可恢复！')) {
                    localDatabase.predictions = [];
                    localStorage.setItem('lotteryDatabase', JSON.stringify(localDatabase));
                    displayPredictionHistory();
                    showSuccess('AI预测历史记录已清空！');
                }
            }
            
            // 刷新数据库信息
            function refreshDbInfo() {
                showDatabaseManager();
                showSuccess('数据库信息已刷新！');
            }
            
            // 将全局函数暴露给onclick事件
            window.exportDatabase = exportDatabase;
            window.clearDatabase = clearDatabase;
            window.clearPredictionHistory = clearPredictionHistory;
            window.refreshDbInfo = refreshDbInfo;

            // 初始化生肖网格布局
            function initZodiacGrid() {
                const zodiacs = Object.keys(zodiacNumbers);
                
                zodiacs.forEach(zodiac => {
                    const column = document.createElement('div');
                    column.className = 'zodiac-column';
                    
                    const header = document.createElement('div');
                    header.className = 'zodiac-header';
                    header.textContent = `生肖${zodiac}`;
                    column.appendChild(header);
                    
                    zodiacNumbers[zodiac].forEach(number => {
                        const numberElement = document.createElement('div');
                        numberElement.className = 'zodiac-number';
                        numberElement.textContent = number.toString().padStart(2, '0');
                        column.appendChild(numberElement);
                    });
                    
                    zodiacGrid.appendChild(column);
                });
            }
            
            // 初始化五行网格布局
            function initElementGrid() {
                const elements = Object.keys(elementNumbers);
                
                elements.forEach(element => {
                    const column = document.createElement('div');
                    column.className = 'element-column';
                    
                    const header = document.createElement('div');
                    header.className = 'element-header';
                    header.textContent = `五行${element}`;
                    column.appendChild(header);
                    
                    elementNumbers[element].forEach(number => {
                        const numberElement = document.createElement('div');
                        numberElement.className = 'element-number';
                        numberElement.textContent = number.toString().padStart(2, '0');
                        column.appendChild(numberElement);
                    });
                    
                    elementGrid.appendChild(column);
                });
            }
            
            // 根据号码获取生肖
            function getZodiacByNumber(number) {
                for (const [zodiac, numbers] of Object.entries(zodiacNumbers)) {
                    if (numbers.includes(parseInt(number))) {
                        return zodiac;
                    }
                }
                return '未知';
            }
            
            // 根据号码获取五行
            function getElementByNumber(number) {
                for (const [element, numbers] of Object.entries(elementNumbers)) {
                    if (numbers.includes(parseInt(number))) {
                        return element;
                    }
                }
                return '未知';
            }
            
            // 初始化倒计时
            function initCountdown() {
                updateCountdown();
                setInterval(updateCountdown, 1000);
            }
            
            // 更新倒计时
            function updateCountdown() {
                const now = new Date();
                const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                
                const drawTime = new Date(today);
                drawTime.setHours(21, 34, 0, 0);
                
                if (now > drawTime) {
                    drawTime.setDate(drawTime.getDate() + 1);
                }
                
                const diff = drawTime - now;
                
                const hours = Math.floor(diff / (1000 * 60 * 60));
                const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((diff % (1000 * 60)) / 1000);
                
                countdownHours.textContent = hours.toString().padStart(2, '0');
                countdownMinutes.textContent = minutes.toString().padStart(2, '0');
                countdownSeconds.textContent = seconds.toString().padStart(2, '0');
                
                const weekdays = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
                const weekday = weekdays[drawTime.getDay()];
                nextDrawTime.textContent = `${drawTime.getFullYear()}-${(drawTime.getMonth()+1).toString().padStart(2, '0')}-${drawTime.getDate().toString().padStart(2, '0')} 21:34:00 ${weekday}`;
                
                const year = drawTime.getFullYear();
                const startOfYear = new Date(year, 0, 1);
                const dayOfYear = Math.floor((drawTime - startOfYear) / (1000 * 60 * 60 * 24)) + 1;
                const period = `${year}${dayOfYear.toString().padStart(3, '0')}`;
                currentPeriod.textContent = `第 ${period} 期`;
            }
            
            // 保存数据到本地数据库
            function saveToLocalDatabase() {
                if (historyData.length === 0) {
                    showError('没有可保存的数据，请先查询历史数据');
                    return;
                }
                
                showLoading();
                
                try {
                    const existingData = localDatabase.history;
                    const newData = [...existingData];
                    let addedCount = 0;
                    let updatedCount = 0;
                    
                    historyData.forEach(item => {
                        const existingIndex = existingData.findIndex(existing => existing.expect === item.expect);
                        if (existingIndex === -1) {
                            newData.push(item);
                            addedCount++;
                        } else {
                            newData[existingIndex] = item;
                            updatedCount++;
                        }
                    });
                    
                    newData.sort((a, b) => parseInt(b.expect) - parseInt(a.expect));
                    
                    localDatabase.history = newData;
                    localDatabase.lastUpdate = new Date().toISOString();
                    localStorage.setItem('lotteryDatabase', JSON.stringify(localDatabase));
                    
                    let message = '数据库更新完成！';
                    if (addedCount > 0) message += ` 新增 ${addedCount} 条记录`;
                    if (updatedCount > 0) message += ` 更新 ${updatedCount} 条记录`;
                    message += ` 总计 ${newData.length} 条记录`;
                    
                    showSuccess(message);
                    showDebugInfo(`数据库统计: 总计 ${newData.length} 条记录`);
                    
                } catch (err) {
                    console.error('保存到数据库失败:', err);
                    showError('保存到数据库失败: ' + err.message);
                } finally {
                    hideLoading();
                }
            }
            
            // 显示预测历史记录
            function displayPredictionHistory() {
                if (!localDatabase.predictions || localDatabase.predictions.length === 0) {
                    aiHistoryResults.innerHTML = '<p>暂无预测历史记录</p>';
                    return;
                }
                
                let historyHTML = '';
                
                localDatabase.predictions.forEach(prediction => {
                    const numbersHTML = prediction.predictedNumbers.map(num => 
                        `<div class="history-prediction">${num}</div>`
                    ).join('');
                    
                    const zodiacsHTML = prediction.predictedZodiacs.map(zodiac => 
                        `<div class="history-prediction">${zodiac}</div>`
                    ).join('');
                    
                    let resultHTML = '';
                    if (prediction.actualResult) {
                        const isCorrect = prediction.isCorrect ? 
                            `<span class="correct">✓ 预测正确</span>` : 
                            `<span class="incorrect">✗ 预测错误</span>`;
                        
                        resultHTML = `
                            <div class="history-result">
                                <span>实际开奖: ${prediction.actualResult}</span>
                                ${isCorrect}
                            </div>
                        `;
                    } else {
                        resultHTML = `
                            <div class="history-result">
                                <span>等待开奖结果...</span>
                            </div>
                        `;
                    }
                    
                    historyHTML += `
                        <div class="history-item">
                            <div class="history-header">
                                <span>预测时间: ${prediction.timestamp}</span>
                                <span>分析期数: ${prediction.period}期</span>
                            </div>
                            <div>
                                <strong>预测号码:</strong>
                                <div class="history-predictions">
                                    ${numbersHTML}
                                </div>
                            </div>
                            <div>
                                <strong>预测生肖:</strong>
                                <div class="history-predictions">
                                    ${zodiacsHTML}
                                </div>
                            </div>
                            ${resultHTML}
                        </div>
                    `;
                });
                
                aiHistoryResults.innerHTML = historyHTML;
            }
            
            // AI智能分析功能
            function performAIAnalysis(periods) {
                if (localDatabase.history.length === 0) {
                    showError('本地数据库中没有数据，请先查询并保存数据');
                    return;
                }
                
                showLoading();
                
                setTimeout(() => {
                    try {
                        const analysisData = localDatabase.history.slice(0, Math.min(periods, localDatabase.history.length));
                        const analysisResult = deepAIAnalysis(analysisData);
                        
                        localDatabase.analysis = analysisResult;
                        savePredictionRecord(analysisResult);
                        localStorage.setItem('lotteryDatabase', JSON.stringify(localDatabase));
                        
                        displayAIAnalysisResults(analysisResult);
                        showSuccess(`AI分析完成！分析了最近 ${analysisData.length} 期数据`);
                        
                    } catch (err) {
                        console.error('AI分析失败:', err);
                        showError('AI分析失败: ' + err.message);
                    } finally {
                        hideLoading();
                    }
                }, 100);
            }
            
            // 深度AI分析
            function deepAIAnalysis(data) {
                // 确保数据格式正确
                const validData = data.filter(item => item && item.openCode);
                
                const analysis = {
                    timestamp: new Date().toLocaleString(),
                    totalPeriods: validData.length,
                    dataRange: {
                        start: validData[validData.length - 1] ? validData[validData.length - 1].openTime : '无数据',
                        end: validData[0] ? validData[0].openTime : '无数据'
                    },
                    basicStats: getBasicStats(validData),
                    specialCodeAnalysis: analyzeSpecialCodeDeep(validData),
                    waveAnalysis: analyzeWavePatterns(validData),
                    zodiacAnalysis: analyzeZodiacPatterns(validData),
                    predictions: generateSmartPredictions(validData),
                    zodiacPredictions: generateZodiacPredictions(validData),
                    conclusions: generateConclusions(validData)
                };
                
                return analysis;
            }
            
            // 获取基础统计
            function getBasicStats(data) {
                const stats = {
                    totalDraws: data.length,
                    dateRange: {
                        start: data[data.length - 1] ? data[data.length - 1].openTime.split(' ')[0] : '无数据',
                        end: data[0] ? data[0].openTime.split(' ')[0] : '无数据'
                    },
                    specialCodeStats: {}
                };
                
                const specialCodeCount = {};
                data.forEach(item => {
                    if (item.openCode) {
                        const numbers = item.openCode.split(',');
                        if (numbers.length >= 7) {
                            const specialCode = parseInt(numbers[6]);
                            specialCodeCount[specialCode] = (specialCodeCount[specialCode] || 0) + 1;
                        }
                    }
                });
                
                stats.specialCodeStats = Object.entries(specialCodeCount)
                    .map(([code, count]) => ({
                        code: parseInt(code),
                        count,
                        frequency: (count / data.length * 100).toFixed(2) + '%'
                    }))
                    .sort((a, b) => b.count - a.count)
                    .slice(0, 10);
                
                return stats;
            }
            
            // 深度特码分析
            function analyzeSpecialCodeDeep(data) {
                const analysis = {
                    parityAnalysis: {},
                    sizeAnalysis: {}
                };
                
                let oddCount = 0, evenCount = 0;
                let bigCount = 0, smallCount = 0;
                
                data.forEach(item => {
                    if (item.openCode) {
                        const numbers = item.openCode.split(',');
                        if (numbers.length >= 7) {
                            const specialCode = parseInt(numbers[6]);
                            if (specialCode % 2 === 0) evenCount++;
                            else oddCount++;
                            
                            if (specialCode > 25) bigCount++;
                            else smallCount++;
                        }
                    }
                });
                
                analysis.parityAnalysis = {
                    odd: { count: oddCount, percentage: (oddCount / data.length * 100).toFixed(2) + '%' },
                    even: { count: evenCount, percentage: (evenCount / data.length * 100).toFixed(2) + '%' }
                };
                
                analysis.sizeAnalysis = {
                    big: { count: bigCount, percentage: (bigCount / data.length * 100).toFixed(2) + '%' },
                    small: { count: smallCount, percentage: (smallCount / data.length * 100).toFixed(2) + '%' }
                };
                
                return analysis;
            }
            
            // 波色模式分析
            function analyzeWavePatterns(data) {
                const trends = {
                    red: 0,
                    blue: 0,
                    green: 0
                };
                
                data.forEach(item => {
                    if (item.wave) {
                        const waves = item.wave.split(',');
                        if (waves.length >= 7) {
                            const specialWave = waves[6];
                            if (trends.hasOwnProperty(specialWave)) {
                                trends[specialWave]++;
                            }
                        }
                    }
                });
                
                trends.redPercentage = (trends.red / data.length * 100).toFixed(2) + '%';
                trends.bluePercentage = (trends.blue / data.length * 100).toFixed(2) + '%';
                trends.greenPercentage = (trends.green / data.length * 100).toFixed(2) + '%';
                
                return trends;
            }
            
            // 生肖模式分析
            function analyzeZodiacPatterns(data) {
                const patterns = {};
                const zodiacCount = {};
                
                data.forEach(item => {
                    if (item.zodiac) {
                        const zodiacs = item.zodiac.split(',');
                        if (zodiacs.length >= 7) {
                            const specialZodiac = zodiacs[6];
                            zodiacCount[specialZodiac] = (zodiacCount[specialZodiac] || 0) + 1;
                        }
                    }
                });
                
                patterns.zodiacFrequency = Object.entries(zodiacCount)
                    .map(([zodiac, count]) => ({
                        zodiac,
                        count,
                        percentage: (count / data.length * 100).toFixed(2) + '%'
                    }))
                    .sort((a, b) => b.count - a.count);
                
                return patterns;
            }
            
            // 生成智能预测
            function generateSmartPredictions(data) {
                const hotNumbers = getBasicStats(data).specialCodeStats.slice(0, 5);
                const waveTrends = analyzeWavePatterns(data);
                
                const dominantWave = Object.entries(waveTrends)
                    .filter(([key]) => !key.includes('Percentage'))
                    .sort((a, b) => b[1] - a[1])[0];
                
                return {
                    recommendedNumbers: hotNumbers.map(item => item.code),
                    waveFocus: dominantWave ? dominantWave[0] : 'blue',
                    confidence: calculateConfidence(data),
                    reasoning: '基于历史数据的热号分析和波色趋势预测'
                };
            }
            
            // 生成生肖预测
            function generateZodiacPredictions(data) {
                const zodiacStats = analyzeZodiacPatterns(data);
                const topZodiacs = zodiacStats.zodiacFrequency.slice(0, 6);
                
                return {
                    topZodiacs: topZodiacs,
                    reasoning: '基于历史数据出现频率最高的生肖预测'
                };
            }
            
            // 计算置信度
            function calculateConfidence(data) {
                if (data.length < 30) return '较低';
                if (data.length < 70) return '中等';
                return '较高';
            }
            
            // 生成分析结论
            function generateConclusions(data) {
                const conclusions = [];
                
                if (data.length >= 50) {
                    conclusions.push('数据量充足，分析结果可靠性较高');
                } else {
                    conclusions.push('数据量有限，建议收集更多数据后重新分析');
                }
                
                const waveAnalysis = analyzeWavePatterns(data);
                const maxWave = Object.entries(waveAnalysis)
                    .filter(([key]) => !key.includes('Percentage'))
                    .sort((a, b) => b[1] - a[1])[0];
                
                if (maxWave) {
                    conclusions.push(`近期${maxWave[0]}波出现频率最高（${waveAnalysis[maxWave[0] + 'Percentage']}）`);
                }
                
                conclusions.push('建议结合多种分析方法综合判断');
                conclusions.push('彩票有风险，投资需谨慎');
                
                return conclusions;
            }
            
            // 保存预测记录
            function savePredictionRecord(analysisResult) {
                if (!localDatabase.predictions) {
                    localDatabase.predictions = [];
                }
                
                const predictionRecord = {
                    id: Date.now(),
                    timestamp: new Date().toLocaleString(),
                    period: analysisResult.totalPeriods,
                    predictedNumbers: analysisResult.predictions.recommendedNumbers,
                    predictedZodiacs: analysisResult.zodiacPredictions.topZodiacs.map(item => item.zodiac),
                    actualResult: null,
                    isCorrect: null
                };
                
                localDatabase.predictions.unshift(predictionRecord);
            }
            
            // 显示AI分析结果
            function displayAIAnalysisResults(analysis) {
                aiAnalysisResults.innerHTML = `
                    <div class="analysis-report">
                        <div class="report-header">
                            <div class="report-meta">
                                <span>分析时间: ${analysis.timestamp}</span>
                                <span>分析期数: ${analysis.totalPeriods}期</span>
                            </div>
                        </div>
                        
                        <div class="analysis-grid">
                            <div class="analysis-card">
                                <h4><i>📈</i> 基础统计</h4>
                                <div class="stats-grid">
                                    <div class="stat-item">
                                        <div class="stat-label">总期数</div>
                                        <div class="stat-value">${analysis.basicStats.totalDraws}</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-label">数据范围</div>
                                        <div class="stat-value">${analysis.basicStats.dateRange.start} 至 ${analysis.basicStats.dateRange.end}</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="analysis-card">
                                <h4><i>🎯</i> 特码分析</h4>
                                <div class="pattern-list">
                                    <div class="pattern-item">
                                        <span>奇偶比例</span>
                                        <span class="pattern-value">${analysis.specialCodeAnalysis.parityAnalysis.odd.percentage} / ${analysis.specialCodeAnalysis.parityAnalysis.even.percentage}</span>
                                    </div>
                                    <div class="pattern-item">
                                        <span>大小比例</span>
                                        <span class="pattern-value">${analysis.specialCodeAnalysis.sizeAnalysis.big.percentage} / ${analysis.specialCodeAnalysis.sizeAnalysis.small.percentage}</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="analysis-card">
                                <h4><i>🎨</i> 波色趋势</h4>
                                <div class="pattern-list">
                                    <div class="pattern-item">
                                        <span>红波</span>
                                        <span class="pattern-value">${analysis.waveAnalysis.redPercentage}</span>
                                    </div>
                                    <div class="pattern-item">
                                        <span>蓝波</span>
                                        <span class="pattern-value">${analysis.waveAnalysis.bluePercentage}</span>
                                    </div>
                                    <div class="pattern-item">
                                        <span>绿波</span>
                                        <span class="pattern-value">${analysis.waveAnalysis.greenPercentage}</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="analysis-card prediction-card">
                                <h4><i>🔮</i> 预测建议</h4>
                                <div class="prediction-numbers">
                                    ${analysis.predictions.recommendedNumbers.map(num => `
                                        <div class="prediction-number">${num}</div>
                                    `).join('')}
                                </div>
                                <div class="prediction-info">
                                    <div>重点波色: ${analysis.predictions.waveFocus}</div>
                                    <div>置信度: ${analysis.predictions.confidence}</div>
                                </div>
                            </div>
                            
                            <div class="analysis-card">
                                <h4><i>🐭</i> 下期特码生肖预测</h4>
                                <div class="hot-numbers">
                                    ${analysis.zodiacPredictions.topZodiacs.map(item => `
                                        <div class="hot-number">
                                            <span class="number">${item.zodiac}</span>
                                            <span class="count">${item.percentage}</span>
                                        </div>
                                    `).join('')}
                                </div>
                                <div style="margin-top: 10px; font-size: 0.8rem; color: #666;">
                                    ${analysis.zodiacPredictions.reasoning}
                                </div>
                            </div>
                            
                            <div class="analysis-card">
                                <h4><i>🔥</i> 热门号码</h4>
                                <div class="hot-numbers">
                                    ${analysis.basicStats.specialCodeStats.slice(0, 8).map(item => `
                                        <div class="hot-number">
                                            <span class="number">${item.code}</span>
                                            <span class="count">${item.count}次</span>
                                        </div>
                                    `).join('')}
                                </div>
                            </div>
                            
                            <div class="analysis-card warning-card">
                                <h4><i>💡</i> 分析结论</h4>
                                <div class="warnings">
                                    ${analysis.conclusions.map(conclusion => `
                                        <div class="warning-item">${conclusion}</div>
                                    `).join('')}
                                </div>
                            </div>
                        </div>
                    </div>
                `;
            }
            
            // 分析走势
            function analyzeTrend(periods) {
                if (historyData.length === 0) {
                    showError('没有可分析的历史数据，请先查询历史数据');
                    return;
                }
                
                showLoading();
                
                setTimeout(() => {
                    const analysisData = historyData.slice(0, Math.min(periods, historyData.length));
                    
                    const specialCodeStats = analyzeSpecialCode(analysisData);
                    const waveStats = analyzeWave(analysisData);
                    const zodiacStats = analyzeZodiac(analysisData);
                    
                    displayTrendResults(specialCodeStats, waveStats, zodiacStats, analysisData.length);
                    
                    hideLoading();
                    showSuccess(`成功分析最近${analysisData.length}期特码走势`);
                }, 1000);
            }
            
            // 统计特码出现次数
            function analyzeSpecialCode(data) {
                const stats = {};
                
                data.forEach(item => {
                    const numbers = item.openCode.split(',');
                    const specialCode = parseInt(numbers[6]);
                    
                    if (!stats[specialCode]) {
                        stats[specialCode] = 0;
                    }
                    stats[specialCode]++;
                });
                
                return Object.entries(stats)
                    .map(([code, count]) => ({ code: parseInt(code), count }))
                    .sort((a, b) => b.count - a.count);
            }
            
            // 统计特码波色出现次数
            function analyzeWave(data) {
                const stats = {
                    'red': 0,
                    'blue': 0,
                    'green': 0
                };
                
                data.forEach(item => {
                    const waves = item.wave.split(',');
                    const specialWave = waves[6];
                    
                    if (stats[specialWave] !== undefined) {
                        stats[specialWave]++;
                    }
                });
                
                return Object.entries(stats)
                    .map(([wave, count]) => ({ wave, count }))
                    .sort((a, b) => b.count - a.count);
            }
            
            // 统计特码生肖出现次数
            function analyzeZodiac(data) {
                const stats = {};
                
                data.forEach(item => {
                    const zodiacs = item.zodiac.split(',');
                    const specialZodiac = zodiacs[6];
                    
                    if (!stats[specialZodiac]) {
                        stats[specialZodiac] = 0;
                    }
                    stats[specialZodiac]++;
                });
                
                return Object.entries(stats)
                    .map(([zodiac, count]) => ({ zodiac, count }))
                    .sort((a, b) => b.count - a.count);
            }
            
            // 显示走势分析结果
            function displayTrendResults(specialCodeStats, waveStats, zodiacStats, totalPeriods) {
                trendResults.innerHTML = '';
                
                // 特码出现次数
                const specialCodeSection = document.createElement('div');
                specialCodeSection.className = 'trend-section';
                specialCodeSection.innerHTML = `
                    <h3>特码出现次数 (共${totalPeriods}期)</h3>
                    ${specialCodeStats.map(item => `
                        <div class="trend-item">
                            <div class="trend-name">
                                <div class="number" style="background-color: #1a2a6c; width: 40px; height: 40px; font-size: 1rem;">
                                    ${item.code}
                                </div>
                                <span>号码 ${item.code}</span>
                            </div>
                            <div class="trend-bar">
                                <div class="trend-bar-fill" style="width: ${(item.count / totalPeriods) * 100}%"></div>
                            </div>
                            <div class="trend-count">${item.count}次</div>
                        </div>
                    `).join('')}
                `;
                trendResults.appendChild(specialCodeSection);
                
                // 特码波色出现次数
                const waveSection = document.createElement('div');
                waveSection.className = 'trend-section';
                waveSection.innerHTML = `
                    <h3>特码波色出现次数</h3>
                    ${waveStats.map(item => {
                        let bgColor = '#1a2a6c';
                        if (item.wave === 'red') bgColor = '#b21f1f';
                        else if (item.wave === 'green') bgColor = '#2a6c2a';
                        
                        return `
                            <div class="trend-item">
                                <div class="trend-name">
                                    <div class="wave-item" style="background-color: ${bgColor}">${item.wave}</div>
                                    <span>${item.wave}波</span>
                                </div>
                                <div class="trend-bar">
                                    <div class="trend-bar-fill" style="width: ${(item.count / totalPeriods) * 100}%"></div>
                                </div>
                                <div class="trend-count">${item.count}次</div>
                            </div>
                        `;
                    }).join('')}
                `;
                trendResults.appendChild(waveSection);
                
                // 特码生肖出现次数
                const zodiacSection = document.createElement('div');
                zodiacSection.className = 'trend-section';
                zodiacSection.innerHTML = `
                    <h3>特码生肖出现次数</h3>
                    ${zodiacStats.map(item => `
                        <div class="trend-item">
                            <div class="trend-name">
                                <div class="zodiac-item">${item.zodiac}</div>
                                <span>生肖${item.zodiac}</span>
                            </div>
                            <div class="trend-bar">
                                <div class="trend-bar-fill" style="width: ${(item.count / totalPeriods) * 100}%"></div>
                            </div>
                            <div class="trend-count">${item.count}次</div>
                        </div>
                    `).join('')}
                `;
                trendResults.appendChild(zodiacSection);
            }
            
            // 获取最新开奖结果
            async function fetchLatestResults() {
                showLoading();
                hideMessages();
                disableButtons(true);
                
                try {
                    const apiUrl = 'https://macaumarksix.com/api/macaujc2.com';
                    showDebugInfo(`正在调用最新开奖API: ${apiUrl}`);
                    
                    const response = await fetch(apiUrl);
                    
                    if (!response.ok) {
                        throw new Error(`HTTP错误! 状态: ${response.status}`);
                    }
                    
                    const data = await response.json();
                    showDebugInfo(`API返回数据: ${JSON.stringify(data, null, 2)}`);
                    
                    if (data && Array.isArray(data) && data.length > 0) {
                        historyData = data;
                        displayResults(data, '最新开奖结果');
                        showSuccess('成功获取最新开奖结果');
                    } else {
                        throw new Error('API返回的数据格式不正确');
                    }
                } catch (err) {
                    console.error('获取最新开奖结果失败:', err);
                    showError('获取最新开奖结果失败: ' + err.message);
                } finally {
                    hideLoading();
                    disableButtons(false);
                }
            }
            
            // 获取实时开奖结果
            async function fetchLiveResults() {
                showLoading();
                hideMessages();
                disableButtons(true);
                
                try {
                    const apiUrl = 'https://macaumarksix.com/api/live2';
                    showDebugInfo(`正在调用实时开奖API: ${apiUrl}`);
                    
                    const response = await fetch(apiUrl);
                    
                    if (!response.ok) {
                        throw new Error(`HTTP错误! 状态: ${response.status}`);
                    }
                    
                    const data = await response.json();
                    showDebugInfo(`API返回数据: ${JSON.stringify(data, null, 2)}`);
                    
                    if (data && Array.isArray(data) && data.length > 0) {
                        historyData = data;
                        displayResults(data, '实时开奖结果');
                        showSuccess('成功获取实时开奖结果');
                    } else {
                        throw new Error('API返回的数据格式不正确');
                    }
                } catch (err) {
                    console.error('获取实时开奖结果失败:', err);
                    showError('获取实时开奖结果失败: ' + err.message);
                } finally {
                    hideLoading();
                    disableButtons(false);
                }
            }
            
            // 获取历史开奖结果
            async function fetchHistoryResults(year, count) {
                showLoading();
                hideMessages();
                disableButtons(true);
                
                try {
                    const apiUrl = `https://history.macaumarksix.com/history/macaujc2/y/${year}`;
                    showDebugInfo(`正在调用历史开奖API: ${apiUrl}`);
                    showDebugInfo(`请求参数: 年份=${year}, 期数=${count}`);
                    
                    const response = await fetch(apiUrl);
                    
                    if (!response.ok) {
                        throw new Error(`HTTP错误! 状态: ${response.status}`);
                    }
                    
                    const data = await response.json();
                    showDebugInfo(`API返回原始数据: ${JSON.stringify(data, null, 2)}`);
                    
                    if (data && data.result && Array.isArray(data.data)) {
                        historyData = data.data;
                        
                        const allExpects = data.data.map(item => item.expect);
                        showDebugInfo(`所有期号: ${allExpects.join(', ')}`);
                        showDebugInfo(`总数据条数: ${data.data.length}`);
                        
                        const uniqueData = [];
                        const seenExpects = new Set();
                        
                        for (const item of data.data) {
                            if (!seenExpects.has(item.expect)) {
                                seenExpects.add(item.expect);
                                uniqueData.push(item);
                            }
                        }
                        
                        showDebugInfo(`去重后期号: ${uniqueData.map(item => item.expect).join(', ')}`);
                        showDebugInfo(`去重后数据条数: ${uniqueData.length}`);
                        
                        const sortedData = uniqueData.sort((a, b) => {
                            return parseInt(b.expect) - parseInt(a.expect);
                        });
                        
                        const limitedData = sortedData.slice(0, count);
                        showDebugInfo(`最终显示期号: ${limitedData.map(item => item.expect).join(', ')}`);
                        
                        if (limitedData.length > 0) {
                            historyData = limitedData;
                            displayResults(limitedData, `${year}年历史开奖结果（最近${count}期）`);
                            showSuccess(`成功获取${year}年最近${count}期历史开奖结果`);
                        } else {
                            throw new Error('没有找到符合条件的历史数据');
                        }
                    } else {
                        throw new Error('API返回的数据格式不正确');
                    }
                } catch (err) {
                    console.error('获取历史开奖结果失败:', err);
                    showError('获取历史开奖结果失败: ' + err.message);
                } finally {
                    hideLoading();
                    disableButtons(false);
                }
            }
            
            // 禁用/启用按钮
            function disableButtons(disabled) {
                const buttons = [latestBtn, liveBtn, historyBtn, trendBtn, debugBtn, analyzeTrendBtn, saveToDbBtn, analyzeWithAIBtn, analyzeWithAIBtn2, dbManageBtn];
                buttons.forEach(btn => {
                    if (btn) btn.disabled = disabled;
                });
            }
            
            // 显示调试信息
            function showDebugInfo(message) {
                if (debugMode) {
                    debugMsg.textContent = message;
                    debugInfo.style.display = 'block';
                }
            }
            
            // 显示加载动画
            function showLoading() {
                loading.style.display = 'block';
                resultContainer.style.display = 'none';
            }
            
            // 隐藏加载动画
            function hideLoading() {
                loading.style.display = 'none';
            }
            
            // 显示错误信息
            function showError(message) {
                errorMsg.textContent = message;
                error.style.display = 'block';
                success.style.display = 'none';
            }
            
            // 显示成功信息
            function showSuccess(message) {
                successMsg.textContent = message;
                success.style.display = 'block';
                error.style.display = 'none';
            }
            
            // 隐藏所有消息
            function hideMessages() {
                error.style.display = 'none';
                success.style.display = 'none';
                if (!debugMode) {
                    debugInfo.style.display = 'none';
                }
            }
            
            // 显示结果
            function displayResults(data, title) {
                resultContainer.innerHTML = `<h3>${title}</h3>`;
                
                if (!data || data.length === 0) {
                    resultContainer.innerHTML += '<p>没有找到相关数据</p>';
                    resultContainer.style.display = 'block';
                    return;
                }
                
                showDebugInfo(`准备显示 ${data.length} 条数据`);
                
                data.forEach((item, index) => {
                    const numbers = item.openCode.split(',');
                    const waves = item.wave ? item.wave.split(',') : ['blue', 'blue', 'blue', 'blue', 'blue', 'blue', 'blue'];
                    const zodiacs = item.zodiac ? item.zodiac.split(',') : ['鼠', '牛', '虎', '兔', '龙', '蛇', '马'];
                    
                    const resultItem = document.createElement('div');
                    resultItem.className = 'result-item';
                    
                    resultItem.innerHTML = `
                        <div class="result-header">
                            <div class="expect">第 ${item.expect} 期</div>
                            <div class="open-time">开奖时间: ${item.openTime}</div>
                        </div>
                        <div class="numbers">
                            ${numbers.map((num, index) => {
                                const numInt = parseInt(num);
                                let bgColor = '#1a2a6c';
                                
                                if (index < waves.length) {
                                    if (waves[index] === 'red') bgColor = '#b21f1f';
                                    else if (waves[index] === 'green') bgColor = '#2a6c2a';
                                }
                                
                                const zodiac = getZodiacByNumber(num);
                                const element = getElementByNumber(num);
                                
                                return `
                                    <div class="number" style="background-color: ${bgColor}">
                                        <div>${num}</div>
                                        <div class="number-zodiac">${zodiac}</div>
                                        <div class="number-element">${element}</div>
                                    </div>
                                `;
                            }).join('')}
                        </div>
                        <div class="wave">
                            ${waves.map(wave => {
                                let bgColor = '#1a2a6c';
                                if (wave === 'red') bgColor = '#b21f1f';
                                else if (wave === 'green') bgColor = '#2a6c2a';
                                
                                return `<div class="wave-item" style="background-color: ${bgColor}">${wave}</div>`;
                            }).join('')}
                        </div>
                        <div class="zodiac">
                            ${zodiacs.map(zodiac => `<div class="zodiac-item">${zodiac}</div>`).join('')}
                        </div>
                        <div style="margin-top: 15px; font-size: 0.9rem; color: #666;">
                            验证状态: ${item.verify ? '已验证' : '未验证'} | 类型: ${item.type || '未知'}
                        </div>
                    `;
                    
                    resultContainer.appendChild(resultItem);
                });
                
                resultContainer.style.display = 'block';
            }
            
            // 调试模式切换
            function toggleDebugMode() {
                debugMode = !debugMode;
                debugBtn.style.background = debugMode ? 
                    'linear-gradient(to right, #ff6b6b, #4ecdc4)' : 
                    'linear-gradient(to right, #1a2a6c, #b21f1f)';
                debugBtn.innerHTML = debugMode ? 
                    '<i>🐛</i> 关闭调试' : 
                    '<i>🐛</i> 调试模式';
                showDebugInfo('调试模式 ' + (debugMode ? '已开启' : '已关闭'));
            }
        });
    </script>
</body>
</html>
