<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>罗老师666开奖查询系统</title>
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
        
        .year-input, .count-input, .periods-input {
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 50px;
            font-size: 1rem;
            width: 150px;
            transition: border-color 0.3s;
        }
        
        .year-input:focus, .count-input:focus, .periods-input:focus {
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
        .zodiac-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 15px;
            margin-top: 15px;
        }
        
        .zodiac-column {
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .zodiac-header {
            background: linear-gradient(135deg, #1a2a6c, #b21f1f);
            color: white;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 10px;
            font-weight: bold;
            font-size: 1.1rem;
        }
        
        .zodiac-number {
            padding: 5px;
            margin: 3px 0;
            background: #f8f9fa;
            border-radius: 5px;
            font-weight: bold;
            color: #1a2a6c;
            border: 1px solid #e9ecef;
        }
        
        .element-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        
        .element-table th, .element-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        
        .element-table th {
            background-color: #1a2a6c;
            color: white;
        }
        
        .element-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .element-table tr:hover {
            background-color: #f1f1f1;
        }
        
        .element-color-gold { color: #ffd700; font-weight: bold; }
        .element-color-wood { color: #228B22; font-weight: bold; }
        .element-color-water { color: #1E90FF; font-weight: bold; }
        .element-color-fire { color: #FF4500; font-weight: bold; }
        .element-color-earth { color: #8B4513; font-weight: bold; }
        
        /* 走势图样式 */
        .trend-controls {
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
        
        .footer {
            text-align: center;
            margin-top: 30px;
            color: white;
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        @media (max-width: 768px) {
            .controls, .trend-controls {
                flex-direction: column;
            }
            
            button {
                width: 100%;
            }
            
            .year-input, .count-input, .periods-input {
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
            
            .zodiac-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
            }
            
            .zodiac-column {
                padding: 10px;
            }
            
            .zodiac-header {
                font-size: 1rem;
                padding: 8px;
            }
        }
        
        @media (max-width: 480px) {
            .zodiac-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>罗老师爱导管查询系统</h1>
            <p>实时获取最新开奖结果和历史数据</p>
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
            <table class="element-table" id="elementTable">
                <thead>
                    <tr>
                        <th>五行</th>
                        <th>号码</th>
                        <th>五行</th>
                        <th>号码</th>
                    </tr>
                </thead>
                <tbody id="elementTableBody">
                    <!-- 五行数据将通过JavaScript填充 -->
                </tbody>
            </table>
        </div>
        
        <!--  <div class="card">
            <h2><i>ℹ️</i> 系统信息</h2>
            <p><strong>最新开奖API：</strong> https://macaumarksix.com/api/macaujc2.com</p>
            <p><strong>实时开奖API：</strong> https://macaumarksix.com/api/live2</p>
            <p><strong>历史开奖API：</strong> https://history.macaumarksix.com/history/macaujc2/y/{year}</p>
            <p><strong>数据来源：</strong> macaujc.com</p>
            <p><strong>技术支持：</strong> service@macaujc.com</p>
        </div>-->
        
        <div class="footer">
            <p>© 2025 罗老师爱导管查询系统 - 本系统仅用于精子库查询导管次数</p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const latestBtn = document.getElementById('latestBtn');
            const liveBtn = document.getElementById('liveBtn');
            const historyBtn = document.getElementById('historyBtn');
            const trendBtn = document.getElementById('trendBtn');
            const debugBtn = document.getElementById('debugBtn');
            const analyzeTrendBtn = document.getElementById('analyzeTrendBtn');
            const closeTrendBtn = document.getElementById('closeTrendBtn');
            const yearInput = document.getElementById('yearInput');
            const countInput = document.getElementById('countInput');
            const periodsInput = document.getElementById('periodsInput');
            const loading = document.getElementById('loading');
            const error = document.getElementById('error');
            const success = document.getElementById('success');
            const debugInfo = document.getElementById('debugInfo');
            const resultContainer = document.getElementById('resultContainer');
            const trendAnalysis = document.getElementById('trendAnalysis');
            const trendResults = document.getElementById('trendResults');
            const zodiacGrid = document.getElementById('zodiacGrid');
            const errorMsg = document.getElementById('errorMsg');
            const successMsg = document.getElementById('successMsg');
            const debugMsg = document.getElementById('debugMsg');
            const elementTableBody = document.getElementById('elementTableBody');
            
            // 倒计时元素
            const currentPeriod = document.getElementById('currentPeriod');
            const nextDrawTime = document.getElementById('nextDrawTime');
            const countdownHours = document.getElementById('countdownHours');
            const countdownMinutes = document.getElementById('countdownMinutes');
            const countdownSeconds = document.getElementById('countdownSeconds');
            
            let debugMode = false;
            let historyData = []; // 存储历史数据
            
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
            
            // 初始化对照表
            initZodiacGrid();
            initElementTable();
            
            // 初始化倒计时
            initCountdown();
            
            // 最新开奖按钮点击事件
            latestBtn.addEventListener('click', function() {
                fetchLatestResults();
            });
            
            // 实时开奖按钮点击事件
            liveBtn.addEventListener('click', function() {
                fetchLiveResults();
            });
            
            // 历史数据按钮点击事件
            historyBtn.addEventListener('click', function() {
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
            });
            
            // 走势图按钮点击事件
            trendBtn.addEventListener('click', function() {
                showTrendAnalysis();
            });
            
            // 分析走势按钮点击事件
            analyzeTrendBtn.addEventListener('click', function() {
                const periods = periodsInput.value;
                if (!periods || periods < 10) {
                    showError('请输入至少10期的分析期数');
                    return;
                }
                analyzeTrend(parseInt(periods));
            });
            
            // 关闭走势分析按钮点击事件
            closeTrendBtn.addEventListener('click', function() {
                hideTrendAnalysis();
            });
            
            // 调试按钮点击事件
            debugBtn.addEventListener('click', function() {
                debugMode = !debugMode;
                debugBtn.style.background = debugMode ? 
                    'linear-gradient(to right, #ff6b6b, #4ecdc4)' : 
                    'linear-gradient(to right, #1a2a6c, #b21f1f)';
                debugBtn.innerHTML = debugMode ? 
                    '<i>🐛</i> 关闭调试' : 
                    '<i>🐛</i> 调试模式';
                showDebugInfo('调试模式 ' + (debugMode ? '已开启' : '已关闭'));
            });
            
            // 初始化生肖网格布局
            function initZodiacGrid() {
                const zodiacs = Object.keys(zodiacNumbers);
                
                zodiacs.forEach(zodiac => {
                    const column = document.createElement('div');
                    column.className = 'zodiac-column';
                    
                    // 生肖标题
                    const header = document.createElement('div');
                    header.className = 'zodiac-header';
                    header.textContent = `生肖${zodiac}`;
                    column.appendChild(header);
                    
                    // 号码列表
                    zodiacNumbers[zodiac].forEach(number => {
                        const numberElement = document.createElement('div');
                        numberElement.className = 'zodiac-number';
                        numberElement.textContent = number.toString().padStart(2, '0');
                        column.appendChild(numberElement);
                    });
                    
                    zodiacGrid.appendChild(column);
                });
            }
            
            // 显示走势分析
            function showTrendAnalysis() {
                trendAnalysis.style.display = 'block';
                resultContainer.style.display = 'none';
                // 如果没有历史数据，先获取一些数据
                if (historyData.length === 0) {
                    fetchHistoryDataForTrend();
                }
            }
            
            // 隐藏走势分析
            function hideTrendAnalysis() {
                trendAnalysis.style.display = 'none';
            }
            
            // 为走势分析获取历史数据
            async function fetchHistoryDataForTrend() {
                showLoading();
                try {
                    const currentYear = new Date().getFullYear();
                    const apiUrl = `https://history.macaumarksix.com/history/macaujc2/y/${currentYear}`;
                    
                    const response = await fetch(apiUrl);
                    
                    if (!response.ok) {
                        throw new Error(`HTTP错误! 状态: ${response.status}`);
                    }
                    
                    const data = await response.json();
                    
                    if (data && data.result && Array.isArray(data.data)) {
                        historyData = data.data;
                        showSuccess('历史数据加载完成，可以进行分析');
                    } else {
                        throw new Error('API返回的数据格式不正确');
                    }
                } catch (err) {
                    console.error('获取历史数据失败:', err);
                    showError('获取历史数据失败: ' + err.message);
                } finally {
                    hideLoading();
                }
            }
            
            // 分析走势
            function analyzeTrend(periods) {
                if (historyData.length === 0) {
                    showError('没有可分析的历史数据，请先查询历史数据');
                    return;
                }
                
                showLoading();
                
                // 模拟分析过程
                setTimeout(() => {
                    // 限制分析期数
                    const analysisData = historyData.slice(0, Math.min(periods, historyData.length));
                    
                    // 统计特码出现次数
                    const specialCodeStats = analyzeSpecialCode(analysisData);
                    
                    // 统计特码波色出现次数
                    const waveStats = analyzeWave(analysisData);
                    
                    // 统计特码生肖出现次数
                    const zodiacStats = analyzeZodiac(analysisData);
                    
                    // 显示分析结果
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
                    const specialCode = parseInt(numbers[6]); // 第七个数字是特码
                    
                    if (!stats[specialCode]) {
                        stats[specialCode] = 0;
                    }
                    stats[specialCode]++;
                });
                
                // 转换为数组并排序
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
                    const specialWave = waves[6]; // 第七个波色是特码波色
                    
                    if (stats[specialWave] !== undefined) {
                        stats[specialWave]++;
                    }
                });
                
                // 转换为数组并排序
                return Object.entries(stats)
                    .map(([wave, count]) => ({ wave, count }))
                    .sort((a, b) => b.count - a.count);
            }
            
            // 统计特码生肖出现次数
            function analyzeZodiac(data) {
                const stats = {};
                
                data.forEach(item => {
                    const zodiacs = item.zodiac.split(',');
                    const specialZodiac = zodiacs[6]; // 第七个生肖是特码生肖
                    
                    if (!stats[specialZodiac]) {
                        stats[specialZodiac] = 0;
                    }
                    stats[specialZodiac]++;
                });
                
                // 转换为数组并排序
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
            
            // 初始化倒计时
            function initCountdown() {
                updateCountdown();
                // 每秒更新一次倒计时
                setInterval(updateCountdown, 1000);
            }
            
            // 更新倒计时
            function updateCountdown() {
                const now = new Date();
                const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                
                // 设置开奖时间为北京时间21:34
                const drawTime = new Date(today);
                drawTime.setHours(21, 34, 0, 0);
                
                // 如果今天已经过了开奖时间，则计算明天的开奖时间
                if (now > drawTime) {
                    drawTime.setDate(drawTime.getDate() + 1);
                }
                
                // 计算时间差（毫秒）
                const diff = drawTime - now;
                
                // 计算小时、分钟、秒
                const hours = Math.floor(diff / (1000 * 60 * 60));
                const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((diff % (1000 * 60)) / 1000);
                
                // 更新倒计时显示
                countdownHours.textContent = hours.toString().padStart(2, '0');
                countdownMinutes.textContent = minutes.toString().padStart(2, '0');
                countdownSeconds.textContent = seconds.toString().padStart(2, '0');
                
                // 更新下一期开奖时间显示
                const weekdays = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
                const weekday = weekdays[drawTime.getDay()];
                nextDrawTime.textContent = `${drawTime.getFullYear()}-${(drawTime.getMonth()+1).toString().padStart(2, '0')}-${drawTime.getDate().toString().padStart(2, '0')} 21:34:00 ${weekday}`;
                
                // 更新当前期号（基于日期计算）
                const year = drawTime.getFullYear();
                const startOfYear = new Date(year, 0, 1);
                const dayOfYear = Math.floor((drawTime - startOfYear) / (1000 * 60 * 60 * 24)) + 1;
                const period = `${year}${dayOfYear.toString().padStart(3, '0')}`;
                currentPeriod.textContent = `第 ${period} 期`;
            }
            
            // 初始化五行对照表
            function initElementTable() {
                const elements = Object.keys(elementNumbers);
                const half = Math.ceil(elements.length / 2);
                
                for (let i = 0; i < half; i++) {
                    const row = document.createElement('tr');
                    
                    // 第一列五行
                    const element1 = elements[i];
                    const cell1 = document.createElement('td');
                    cell1.innerHTML = `<span class="element-color-${getElementClass(element1)}">${element1}</span>`;
                    row.appendChild(cell1);
                    
                    const numbers1 = document.createElement('td');
                    numbers1.textContent = elementNumbers[element1].join(', ');
                    row.appendChild(numbers1);
                    
                    // 第二列五行（如果存在）
                    if (i + half < elements.length) {
                        const element2 = elements[i + half];
                        const cell2 = document.createElement('td');
                        cell2.innerHTML = `<span class="element-color-${getElementClass(element2)}">${element2}</span>`;
                        row.appendChild(cell2);
                        
                        const numbers2 = document.createElement('td');
                        numbers2.textContent = elementNumbers[element2].join(', ');
                        row.appendChild(numbers2);
                    } else {
                        // 如果第二列不存在，添加空单元格
                        row.appendChild(document.createElement('td'));
                        row.appendChild(document.createElement('td'));
                    }
                    
                    elementTableBody.appendChild(row);
                }
            }
            
            // 获取五行对应的CSS类名
            function getElementClass(element) {
                const elementMap = {
                    '金': 'gold',
                    '木': 'wood',
                    '水': 'water',
                    '火': 'fire',
                    '土': 'earth'
                };
                return elementMap[element] || 'earth';
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
                        // 存储历史数据用于走势分析
                        historyData = data.data;
                        
                        // 调试：显示所有期号
                        const allExpects = data.data.map(item => item.expect);
                        showDebugInfo(`所有期号: ${allExpects.join(', ')}`);
                        showDebugInfo(`总数据条数: ${data.data.length}`);
                        
                        // 去重处理：基于期号去重
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
                        
                        // 按期号倒序排列并限制数量
                        const sortedData = uniqueData.sort((a, b) => {
                            return parseInt(b.expect) - parseInt(a.expect);
                        });
                        
                        const limitedData = sortedData.slice(0, count);
                        showDebugInfo(`最终显示期号: ${limitedData.map(item => item.expect).join(', ')}`);
                        
                        if (limitedData.length > 0) {
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
                latestBtn.disabled = disabled;
                liveBtn.disabled = disabled;
                historyBtn.disabled = disabled;
                trendBtn.disabled = disabled;
                debugBtn.disabled = disabled;
                analyzeTrendBtn.disabled = disabled;
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
                
                // 显示数据统计
                showDebugInfo(`准备显示 ${data.length} 条数据`);
                
                data.forEach((item, index) => {
                    const numbers = item.openCode.split(',');
                    const waves = item.wave.split(',');
                    const zodiacs = item.zodiac.split(',');
                    
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
                                let bgColor = '#1a2a6c'; // 默认蓝色
                                
                                // 根据波色设置背景颜色
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
                                let bgColor = '#1a2a6c'; // 默认蓝色
                                if (wave === 'red') bgColor = '#b21f1f';
                                else if (wave === 'green') bgColor = '#2a6c2a';
                                
                                return `<div class="wave-item" style="background-color: ${bgColor}">${wave}</div>`;
                            }).join('')}
                        </div>
                        <div class="zodiac">
                            ${zodiacs.map(zodiac => `<div class="zodiac-item">${zodiac}</div>`).join('')}
                        </div>
                        <div style="margin-top: 15px; font-size: 0.9rem; color: #666;">
                            验证状态: ${item.verify ? '已验证' : '未验证'} | 类型: ${item.type}
                        </div>
                    `;
                    
                    resultContainer.appendChild(resultItem);
                });
                
                resultContainer.style.display = 'block';
            }
        });
    </script>
</body>
</html>
