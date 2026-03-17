<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>模拟统计界面 - 独立参照弹窗</title>
    <style>
        /* 样式保持不变，只添加新样式 */
        body {
            font-family: "Microsoft Yahei", sans-serif;
            background: #f0f0f0;
            margin: 20px;
        }
        .container {
            background: #fff;
            border: 1px solid #ccc;
            padding: 10px;
            max-width: 1200px;
        }
        .top-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
            flex-wrap: wrap;
        }
        .top-bar button {
            padding: 8px 16px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            background: #f5f5f5;
            border-radius: 4px;
        }
        .top-bar button:hover {
            background: #e0e0e0;
        }
        .top-bar button.recognize-btn {
            background: #ff6b6b;
            color: white;
            font-weight: bold;
        }
        .top-bar button.recognize-btn:hover {
            background: #ff5252;
        }
        .top-bar button.save-btn {
            background: #27ae60;
            color: white;
            font-weight: bold;
        }
        .top-bar button.save-btn:hover {
            background: #219a52;
        }
        .customer-info {
            margin-bottom: 10px;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 10px;
        }
        .table-area {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
        }
        .col {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .row {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .row span {
            width: 50px;
            font-weight: bold;
        }
        .row input {
            flex: 1;
            padding: 4px;
            border: 1px solid #ccc;
        }
        .red { color: red; }
        .blue { color: blue; }
        .green { color: green; }
        .summary {
            margin-top: 15px;
            padding: 10px;
            border-top: 1px solid #ccc;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            background: #f9f9f9;
            border-radius: 4px;
        }
        .amount-item {
            font-weight: bold;
        }
        .current-amount {
            color: #ff6600;
        }
        .accumulate-amount {
            color: #0099ff;
        }
        .data-code {
            margin-left: auto;
            color: #666;
        }

        /* 识别弹窗 */
        .recognize-modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }
        .recognize-content {
            background: white;
            width: 700px;
            max-width: 95%;
            max-height: 80vh;
            border-radius: 24px;
            box-shadow: 0 30px 70px rgba(0,0,0,0.4);
            display: flex;
            flex-direction: column;
            padding: 30px;
        }
        .recognize-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid #ff6b6b;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .recognize-header h3 {
            margin: 0;
            font-size: 2rem;
            color: #ff6b6b;
            font-weight: 700;
        }
        .recognize-close {
            font-size: 40px;
            cursor: pointer;
            color: #95a5a6;
        }
        .recognize-close:hover {
            color: #e74c3c;
        }
        .recognize-input-area {
            margin-bottom: 20px;
        }
        .recognize-input-area textarea {
            width: 100%;
            height: 200px;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 1rem;
            font-family: monospace;
            resize: vertical;
        }
        .recognize-input-area textarea:focus {
            border-color: #ff6b6b;
            outline: none;
        }
        .recognize-example {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 0.95rem;
            color: #2c3e50;
            border-left: 4px solid #ff6b6b;
        }
        .recognize-example p {
            margin: 5px 0;
        }
        .recognize-example code {
            background: #ecf0f1;
            padding: 2px 6px;
            border-radius: 4px;
            color: #e74c3c;
        }
        .recognize-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }
        .recognize-actions button {
            padding: 12px 30px;
            border: none;
            border-radius: 40px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-parse {
            background: #ff6b6b;
            color: white;
        }
        .btn-parse:hover {
            background: #ff5252;
        }
        .btn-cancel {
            background: #ecf0f1;
            color: #2c3e50;
        }
        .btn-cancel:hover {
            background: #bdc3c7;
        }
        .parse-result {
            margin-top: 15px;
            padding: 15px;
            border-radius: 12px;
            background: #f0f9f0;
            color: #27ae60;
            display: none;
        }
        .parse-result.show {
            display: block;
        }

        /* 保存记录弹窗 */
        .save-modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 2001;
        }
        .save-content {
            background: white;
            width: 500px;
            max-width: 95%;
            border-radius: 24px;
            box-shadow: 0 30px 70px rgba(0,0,0,0.4);
            display: flex;
            flex-direction: column;
            padding: 30px;
        }
        .save-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid #27ae60;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .save-header h3 {
            margin: 0;
            font-size: 2rem;
            color: #27ae60;
            font-weight: 700;
        }
        .save-close {
            font-size: 40px;
            cursor: pointer;
            color: #95a5a6;
        }
        .save-close:hover {
            color: #e74c3c;
        }
        .save-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
        }
        .save-info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 1.2rem;
        }
        .save-info-item .label {
            color: #7f8c8d;
        }
        .save-info-item .value {
            font-weight: bold;
            color: #27ae60;
        }
        .save-input-area {
            margin-bottom: 20px;
        }
        .save-input-area label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
        }
        .save-input-area input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 1rem;
        }
        .save-input-area input:focus {
            border-color: #27ae60;
            outline: none;
        }
        .save-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }
        .save-actions button {
            padding: 12px 30px;
            border: none;
            border-radius: 40px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-save {
            background: #27ae60;
            color: white;
        }
        .btn-save:hover {
            background: #219a52;
        }
        .btn-cancel-save {
            background: #ecf0f1;
            color: #2c3e50;
        }
        .btn-cancel-save:hover {
            background: #bdc3c7;
        }

        /* 其他弹窗样式保持不变 */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            width: 1100px;
            max-width: 95%;
            max-height: 90vh;
            border-radius: 20px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.4);
            display: flex;
            flex-direction: column;
            padding: 30px;
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid #2c3e50;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .modal-header h3 {
            margin: 0;
            font-size: 2rem;
            color: #2c3e50;
            font-weight: 700;
        }
        .close-btn {
            font-size: 40px;
            cursor: pointer;
            color: #7f8c8d;
            line-height: 1;
        }
        .close-btn:hover {
            color: #e74c3c;
        }
        
        .view-toggle {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        .view-btn {
            padding: 12px 30px;
            font-size: 1.2rem;
            border: 2px solid #3498db;
            background: white;
            color: #3498db;
            border-radius: 40px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s;
        }
        .view-btn.active {
            background: #3498db;
            color: white;
        }
        .view-btn:hover {
            background: #2980b9;
            color: white;
        }
        
        .numbers-grid {
            background: #f8fafc;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid #dde7f0;
            max-height: 500px;
            overflow-y: auto;
        }
        .grid-container {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 12px;
        }
        .number-card {
            background: white;
            border-radius: 14px;
            padding: 12px 8px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
            transition: transform 0.2s;
        }
        .number-card:hover {
            transform: translateY(-3px);
            border-color: #3498db;
        }
        .number-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            margin-bottom: 10px;
        }
        .number-badge {
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            background: #34495e;
            color: white;
            border-radius: 50%;
            font-weight: bold;
        }
        .animal-tag {
            font-size: 1rem;
            font-weight: 600;
            color: #16a085;
            background: #e8f8f5;
            padding: 4px 10px;
            border-radius: 30px;
        }
        .amount-display {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2980b9;
            background: #ebf5ff;
            padding: 8px 5px;
            border-radius: 10px;
        }
        
        .animals-grid {
            background: #f5f0fa;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid #d0b7e6;
            max-height: 500px;
            overflow-y: auto;
        }
        .animal-card {
            background: white;
            border-radius: 20px;
            padding: 20px 15px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(142,68,173,0.15);
            border: 1px solid #e0d0f0;
            transition: transform 0.2s;
        }
        .animal-card:hover {
            transform: translateY(-5px);
            border-color: #9b59b6;
        }
        .animal-icon {
            font-size: 2.5rem;
            font-weight: 700;
            color: #8e44ad;
            background: #f4e9ff;
            width: 80px;
            height: 80px;
            line-height: 80px;
            border-radius: 50%;
            margin: 0 auto 15px;
        }
        .animal-name {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .animal-amount {
            font-size: 2rem;
            font-weight: 800;
            color: #27ae60;
            background: #e8f8f5;
            padding: 12px 5px;
            border-radius: 50px;
            margin-top: 10px;
        }
        .animal-numbers {
            font-size: 0.9rem;
            color: #7f8c8d;
            margin-top: 8px;
            background: #ecf0f1;
            padding: 5px;
            border-radius: 30px;
        }
        
        .wave-red {
            color: #c0392b;
            background: #fadbd8;
            padding: 2px 8px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-block;
        }
        .wave-blue {
            color: #2980b9;
            background: #d4e6f1;
            padding: 2px 8px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-block;
        }
        .wave-green {
            color: #27ae60;
            background: #d5f5e3;
            padding: 2px 8px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-block;
        }
        
        .reference-modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 1001;
        }
        .reference-content {
            background: white;
            width: 900px;
            max-width: 95%;
            max-height: 85vh;
            border-radius: 24px;
            box-shadow: 0 30px 70px rgba(0,0,0,0.4);
            display: flex;
            flex-direction: column;
            padding: 30px;
        }
        .reference-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid #8e44ad;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .reference-header h3 {
            margin: 0;
            font-size: 2rem;
            color: #8e44ad;
            font-weight: 700;
        }
        .reference-close {
            font-size: 40px;
            cursor: pointer;
            color: #95a5a6;
        }
        .reference-close:hover {
            color: #e74c3c;
        }
        .reference-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            overflow-y: auto;
            max-height: 500px;
            padding: 10px;
        }
        .ref-item {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 20px;
            border-left: 8px solid;
            transition: transform 0.2s;
        }
        .ref-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .ref-item.鼠 { border-color: #7f8c8d; }
        .ref-item.牛 { border-color: #8e44ad; }
        .ref-item.虎 { border-color: #e67e22; }
        .ref-item.兔 { border-color: #e74c3c; }
        .ref-item.龙 { border-color: #f1c40f; }
        .ref-item.蛇 { border-color: #2ecc71; }
        .ref-item.马 { border-color: #3498db; }
        .ref-item.羊 { border-color: #1abc9c; }
        .ref-item.猴 { border-color: #9b59b6; }
        .ref-item.鸡 { border-color: #e67e22; }
        .ref-item.狗 { border-color: #e74c3c; }
        .ref-item.猪 { border-color: #95a5a6; }
        
        .ref-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: #2c3e50;
        }
        .ref-numbers {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .ref-number-row {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.2rem;
            padding: 5px 0;
            border-bottom: 1px dashed #eee;
        }
        .ref-number-value {
            font-weight: 700;
            min-width: 40px;
        }
        
        .wave-modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 1002;
        }
        .wave-content {
            background: white;
            width: 800px;
            max-width: 95%;
            max-height: 80vh;
            border-radius: 24px;
            box-shadow: 0 30px 70px rgba(0,0,0,0.4);
            display: flex;
            flex-direction: column;
            padding: 30px;
        }
        .wave-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid #e67e22;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .wave-header h3 {
            margin: 0;
            font-size: 2rem;
            color: #e67e22;
            font-weight: 700;
        }
        .wave-close {
            font-size: 40px;
            cursor: pointer;
            color: #95a5a6;
        }
        .wave-close:hover {
            color: #e74c3c;
        }
        .wave-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            overflow-y: auto;
            max-height: 500px;
            padding: 15px;
        }
        .wave-section {
            background: #f8f9fa;
            border-radius: 20px;
            padding: 25px 15px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }
        .wave-section.red-section {
            border-top: 8px solid #e74c3c;
        }
        .wave-section.blue-section {
            border-top: 8px solid #3498db;
        }
        .wave-section.green-section {
            border-top: 8px solid #27ae60;
        }
        .wave-section-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 20px;
        }
        .wave-section-title.red { color: #e74c3c; }
        .wave-section-title.blue { color: #3498db; }
        .wave-section-title.green { color: #27ae60; }
        
        .wave-numbers-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
        }
        .wave-number-item {
            font-size: 1.3rem;
            font-weight: 700;
            padding: 10px;
            border-radius: 12px;
        }
        .wave-number-item.red {
            background: #fadbd8;
            color: #c0392b;
        }
        .wave-number-item.blue {
            background: #d4e6f1;
            color: #2980b9;
        }
        .wave-number-item.green {
            background: #d5f5e3;
            color: #27ae60;
        }
        
        .highlight-max {
            border: 3px solid #f39c12 !important;
            background: #fff9e6 !important;
        }
        .highlight-min {
            border: 3px solid #3498db !important;
            background: #e8f0fe !important;
        }
        
        .filter-bar {
            display: flex;
            gap: 30px;
            margin-bottom: 25px;
            flex-wrap: wrap;
            align-items: center;
            background: #ecf0f1;
            padding: 18px 25px;
            border-radius: 60px;
        }
        .filter-bar label {
            display: flex;
            align-items: center;
            gap: 15px;
            font-weight: 600;
            font-size: 1.2rem;
            color: #2c3e50;
        }
        .filter-bar select {
            padding: 12px 25px;
            border: 2px solid #3498db;
            border-radius: 40px;
            font-size: 1.1rem;
            background: white;
            min-width: 220px;
            cursor: pointer;
        }
        .filter-bar button {
            padding: 12px 35px;
            background: #2980b9;
            color: white;
            border: none;
            border-radius: 40px;
            cursor: pointer;
            font-size: 1.2rem;
            font-weight: bold;
        }
        .filter-bar button:hover {
            background: #1f618d;
        }
        .total-accum-bar {
            font-size: 1.6rem;
            font-weight: bold;
            color: #1a5276;
            background: #d4e6f1;
            padding: 18px 30px;
            border-radius: 60px;
            text-align: right;
            border: 2px solid #2980b9;
        }
        .total-accum-bar span {
            color: #c0392b;
            font-size: 2.3rem;
            margin-left: 25px;
            background: #fadbd8;
            padding: 8px 30px;
            border-radius: 60px;
        }

        /* 保存记录列表弹窗 */
        .history-modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 1003;
        }
        
        .history-content {
            background: white;
            width: 1100px;
            max-width: 95%;
            max-height: 85vh;
            border-radius: 24px;
            box-shadow: 0 30px 70px rgba(0,0,0,0.4);
            display: flex;
            flex-direction: column;
            padding: 30px;
        }
        
        .history-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid #667eea;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        
        .history-header h3 {
            margin: 0;
            font-size: 2rem;
            color: #667eea;
            font-weight: 700;
        }
        
        .history-close {
            font-size: 40px;
            cursor: pointer;
            color: #95a5a6;
        }
        
        .history-close:hover {
            color: #e74c3c;
        }
        
        .history-stats {
            background: #f8f9fa;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
            border: 1px solid #e0e0e0;
        }
        
        .total-stats {
            display: flex;
            justify-content: space-around;
            text-align: center;
        }
        
        .stat-item {
            flex: 1;
        }
        
        .stat-label {
            font-size: 1.2rem;
            color: #7f8c8d;
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .stat-value.total {
            color: #e74c3c;
        }
        
        .stat-value.avg {
            color: #3498db;
        }
        
        .stat-value.count {
            color: #27ae60;
        }
        
        .history-list {
            background: white;
            border-radius: 16px;
            border: 1px solid #e0e0e0;
            overflow: hidden;
        }
        
        .history-list-header {
            display: grid;
            grid-template-columns: 2fr 1fr 1.5fr 1.5fr 1fr;
            background: #667eea;
            color: white;
            padding: 15px 20px;
            font-weight: bold;
            font-size: 1.1rem;
        }
        
        .history-list-body {
            max-height: 400px;
            overflow-y: auto;
        }
        
        .history-item {
            display: grid;
            grid-template-columns: 2fr 1fr 1.5fr 1.5fr 1fr;
            padding: 15px 20px;
            border-bottom: 1px solid #ecf0f1;
            align-items: center;
            cursor: pointer;
        }
        
        .history-item:hover {
            background: #f8f9fa;
        }
        
        .history-item .date {
            font-weight: bold;
            color: #2c3e50;
        }
        
        .history-item .amount {
            font-weight: bold;
            color: #27ae60;
        }
        
        .history-item .numbers-count {
            color: #3498db;
        }
        
        .history-item .remark {
            color: #e67e22;
            font-style: italic;
        }
        
        .history-item .delete {
            color: #e74c3c;
            cursor: pointer;
            text-align: right;
        }
        
        .history-item .delete:hover {
            font-weight: bold;
        }
        
        .history-actions {
            margin-top: 20px;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }
        
        .history-actions button {
            padding: 12px 25px;
            border: none;
            border-radius: 40px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        
        .btn-clear-history {
            background: #e74c3c;
            color: white;
        }
        
        .btn-clear-history:hover {
            background: #c0392b;
        }
        
        .btn-export {
            background: #3498db;
            color: white;
        }
        
        .btn-export:hover {
            background: #2980b9;
        }
        
        .btn-refresh {
            background: #95a5a6;
            color: white;
        }
        
        .btn-refresh:hover {
            background: #7f8c8d;
        }
        
        /* 记录详情弹窗 */
        .detail-modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 1100;
        }
        
        .detail-content {
            background: white;
            width: 800px;
            max-width: 95%;
            max-height: 80vh;
            border-radius: 20px;
            padding: 30px;
            overflow-y: auto;
        }
        
        .detail-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #667eea;
        }
        
        .detail-header h4 {
            font-size: 1.5rem;
            color: #2c3e50;
            margin: 0;
        }
        
        .detail-close {
            font-size: 30px;
            cursor: pointer;
            color: #95a5a6;
        }
        
        .detail-close:hover {
            color: #e74c3c;
        }
        
        .detail-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }
        
        .detail-numbers-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 10px;
            margin-top: 20px;
        }
        
        .detail-number-item {
            background: #f0f3f8;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
        }
        
        .detail-number-item .num {
            font-weight: bold;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }
        
        .detail-number-item .animal {
            font-size: 0.9rem;
            color: #7f8c8d;
            margin-bottom: 5px;
        }
        
        .detail-number-item .val {
            color: #27ae60;
            font-weight: bold;
        }
        
        .detail-number-item.red .num { color: red; }
        .detail-number-item.blue .num { color: blue; }
        .detail-number-item.green .num { color: green; }
        
        .confirm-modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 1200;
        }
        
        .confirm-content {
            background: white;
            width: 400px;
            border-radius: 20px;
            padding: 30px;
            text-align: center;
        }
        
        .confirm-content h4 {
            font-size: 1.5rem;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        
        .confirm-content p {
            font-size: 1.1rem;
            color: #2c3e50;
            margin-bottom: 30px;
        }
        
        .confirm-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        
        .confirm-buttons button {
            padding: 12px 30px;
            border: none;
            border-radius: 40px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
        }
        
        .btn-confirm-yes {
            background: #e74c3c;
            color: white;
        }
        
        .btn-confirm-yes:hover {
            background: #c0392b;
        }
        
        .btn-confirm-no {
            background: #ecf0f1;
            color: #2c3e50;
        }
        
        .btn-confirm-no:hover {
            background: #bdc3c7;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <button>接单</button>
            <button id="referenceBtn">生肖参照</button>
            <button id="waveBtn">波色参照</button>
            <button>操作详单</button>
            <button id="summaryBtn">汇总</button>
            <button id="clearAllBtn" style="color:red;">清空累计数据</button>
            <button id="saveBtn" class="save-btn" style="background: #27ae60; color: white;">💾 保存投注</button>
            <button id="historyBtn" style="background: #667eea; color: white;">📊 投注记录</button>
            <button id="reportBtn" style="color:red;">一键上报</button>
            <button id="recognizeBtn" class="recognize-btn" style="background: #ff6b6b; color: white;">🔍 识别金额</button>
        </div>

        <div class="customer-info">
            客户: <input type="text" value="2222" style="width: 60px;">
            <label><input type="checkbox"> 包特</label>
            <label><input type="checkbox"> 平连码</label>
            <label><input type="checkbox"> 特平</label>
            <label><input type="checkbox"> 软键盘</label>
            <label><input type="checkbox"> 小数/整数</label>
            <span style="margin-left: 20px;">本单汇总: <span id="orderTotal">0</span></span>
            <button id="clearOrderBtn" style="margin-left: 20px; color: #ff0000;">清空本单汇总</button>
        </div>

        <div class="table-area">
            <!-- 第一列 01~12 -->
            <div class="col">
                <div class="row"><span class="red">01马</span><input type="text" class="amount-input" data-number="01" data-animal="马"></div>
                <div class="row"><span class="red">02蛇</span><input type="text" class="amount-input" data-number="02" data-animal="蛇"></div>
                <div class="row"><span class="blue">03龙</span><input type="text" class="amount-input" data-number="03" data-animal="龙"></div>
                <div class="row"><span class="blue">04兔</span><input type="text" class="amount-input" data-number="04" data-animal="兔"></div>
                <div class="row"><span class="green">05虎</span><input type="text" class="amount-input" data-number="05" data-animal="虎"></div>
                <div class="row"><span class="green">06牛</span><input type="text" class="amount-input" data-number="06" data-animal="牛"></div>
                <div class="row"><span class="red">07鼠</span><input type="text" class="amount-input" data-number="07" data-animal="鼠"></div>
                <div class="row"><span class="red">08猪</span><input type="text" class="amount-input" data-number="08" data-animal="猪"></div>
                <div class="row"><span class="blue">09狗</span><input type="text" class="amount-input" data-number="09" data-animal="狗"></div>
                <div class="row"><span class="blue">10鸡</span><input type="text" class="amount-input" data-number="10" data-animal="鸡"></div>
                <div class="row"><span class="green">11猴</span><input type="text" class="amount-input" data-number="11" data-animal="猴"></div>
                <div class="row"><span class="red">12羊</span><input type="text" class="amount-input" data-number="12" data-animal="羊"></div>
            </div>
            <!-- 第二列 13~24 -->
            <div class="col">
                <div class="row"><span class="red">13马</span><input type="text" class="amount-input" data-number="13" data-animal="马"></div>
                <div class="row"><span class="blue">14蛇</span><input type="text" class="amount-input" data-number="14" data-animal="蛇"></div>
                <div class="row"><span class="blue">15龙</span><input type="text" class="amount-input" data-number="15" data-animal="龙"></div>
                <div class="row"><span class="green">16兔</span><input type="text" class="amount-input" data-number="16" data-animal="兔"></div>
                <div class="row"><span class="green">17虎</span><input type="text" class="amount-input" data-number="17" data-animal="虎"></div>
                <div class="row"><span class="red">18牛</span><input type="text" class="amount-input" data-number="18" data-animal="牛"></div>
                <div class="row"><span class="red">19鼠</span><input type="text" class="amount-input" data-number="19" data-animal="鼠"></div>
                <div class="row"><span class="blue">20猪</span><input type="text" class="amount-input" data-number="20" data-animal="猪"></div>
                <div class="row"><span class="green">21狗</span><input type="text" class="amount-input" data-number="21" data-animal="狗"></div>
                <div class="row"><span class="green">22鸡</span><input type="text" class="amount-input" data-number="22" data-animal="鸡"></div>
                <div class="row"><span class="red">23猴</span><input type="text" class="amount-input" data-number="23" data-animal="猴"></div>
                <div class="row"><span class="red">24羊</span><input type="text" class="amount-input" data-number="24" data-animal="羊"></div>
            </div>
            <!-- 第三列 25~36 -->
            <div class="col">
                <div class="row"><span class="blue">25马</span><input type="text" class="amount-input" data-number="25" data-animal="马"></div>
                <div class="row"><span class="blue">26蛇</span><input type="text" class="amount-input" data-number="26" data-animal="蛇"></div>
                <div class="row"><span class="green">27龙</span><input type="text" class="amount-input" data-number="27" data-animal="龙"></div>
                <div class="row"><span class="green">28兔</span><input type="text" class="amount-input" data-number="28" data-animal="兔"></div>
                <div class="row"><span class="red">29虎</span><input type="text" class="amount-input" data-number="29" data-animal="虎"></div>
                <div class="row"><span class="red">30牛</span><input type="text" class="amount-input" data-number="30" data-animal="牛"></div>
                <div class="row"><span class="blue">31鼠</span><input type="text" class="amount-input" data-number="31" data-animal="鼠"></div>
                <div class="row"><span class="green">32猪</span><input type="text" class="amount-input" data-number="32" data-animal="猪"></div>
                <div class="row"><span class="green">33狗</span><input type="text" class="amount-input" data-number="33" data-animal="狗"></div>
                <div class="row"><span class="red">34鸡</span><input type="text" class="amount-input" data-number="34" data-animal="鸡"></div>
                <div class="row"><span class="red">35猴</span><input type="text" class="amount-input" data-number="35" data-animal="猴"></div>
                <div class="row"><span class="blue">36羊</span><input type="text" class="amount-input" data-number="36" data-animal="羊"></div>
            </div>
            <!-- 第四列 37~49 -->
            <div class="col">
                <div class="row"><span class="blue">37马</span><input type="text" class="amount-input" data-number="37" data-animal="马"></div>
                <div class="row"><span class="green">38蛇</span><input type="text" class="amount-input" data-number="38" data-animal="蛇"></div>
                <div class="row"><span class="green">39龙</span><input type="text" class="amount-input" data-number="39" data-animal="龙"></div>
                <div class="row"><span class="red">40兔</span><input type="text" class="amount-input" data-number="40" data-animal="兔"></div>
                <div class="row"><span class="blue">41虎</span><input type="text" class="amount-input" data-number="41" data-animal="虎"></div>
                <div class="row"><span class="blue">42牛</span><input type="text" class="amount-input" data-number="42" data-animal="牛"></div>
                <div class="row"><span class="green">43鼠</span><input type="text" class="amount-input" data-number="43" data-animal="鼠"></div>
                <div class="row"><span class="green">44猪</span><input type="text" class="amount-input" data-number="44" data-animal="猪"></div>
                <div class="row"><span class="red">45狗</span><input type="text" class="amount-input" data-number="45" data-animal="狗"></div>
                <div class="row"><span class="red">46鸡</span><input type="text" class="amount-input" data-number="46" data-animal="鸡"></div>
                <div class="row"><span class="blue">47猴</span><input type="text" class="amount-input" data-number="47" data-animal="猴"></div>
                <div class="row"><span class="blue">48羊</span><input type="text" class="amount-input" data-number="48" data-animal="羊"></div>
                <div class="row"><span class="green">49马</span><input type="text" class="amount-input" data-number="49" data-animal="马"></div>
            </div>
        </div>

        <!-- 汇总区域 -->
        <div class="summary">
            <div>散码总数: <span id="scatterTotal">0</span></div>
            <div class="amount-item current-amount">本次上报金额：¥<span id="reportTotal">0</span></div>
            <div class="amount-item accumulate-amount">累计上报金额：¥<span id="accumulateTotal">0</span></div>
            <div class="data-code">2222新澳数据[A2BEF]</div>
        </div>

        <div style="margin-top:15px; padding-top:10px; border-top:1px solid #ccc;">
            <button>散码汇总</button>
            <button>包特汇总</button>
            <button>平连码汇总</button>
            <button>特平汇总</button>
            <button>导出数据</button>
        </div>
    </div>

    <!-- 汇总弹窗 -->
    <div id="summaryModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h3>📊 累计金额总览</h3>
                <span class="close-btn" id="closeModalBtn">&times;</span>
            </div>
            
            <div class="view-toggle">
                <button id="viewNumbersBtn" class="view-btn active">📱 按号码查看</button>
                <button id="viewAnimalsBtn" class="view-btn">🐾 按生肖查看</button>
            </div>
            
            <div class="filter-bar">
                <label>🔍 排序方式：
                    <select id="sortSelect">
                        <option value="number">按号码顺序 (1-49)</option>
                        <option value="animalOrder">按生肖顺序</option>
                        <option value="desc">金额从高到低</option>
                        <option value="asc">金额从低到高</option>
                    </select>
                </label>
                <button id="applyFilterBtn">应用排序</button>
                <span style="margin-left:auto; font-size:1.2rem;">🏆 最高亮金 / 💎 最低亮蓝</span>
            </div>
            
            <div id="numbersView" class="numbers-grid" style="display: block;">
                <div class="grid-container" id="numbersGrid"></div>
            </div>
            
            <div id="animalsView" class="animals-grid" style="display: none;">
                <div class="grid-container" id="animalsGrid"></div>
            </div>
            
            <div class="total-accum-bar">
                累计总金额 <span id="modalAccumTotal">0.00</span>
            </div>
        </div>
    </div>

    <!-- 生肖参照弹窗 -->
    <div id="referenceModal" class="reference-modal">
        <div class="reference-content">
            <div class="reference-header">
                <h3>📋 生肖参照表</h3>
                <span class="reference-close" id="closeReferenceBtn">&times;</span>
            </div>
            <div class="reference-grid" id="referenceGrid"></div>
        </div>
    </div>

    <!-- 波色参照弹窗 -->
    <div id="waveModal" class="wave-modal">
        <div class="wave-content">
            <div class="wave-header">
                <h3>🎨 波色参照表</h3>
                <span class="wave-close" id="closeWaveBtn">&times;</span>
            </div>
            <div class="wave-grid" id="waveGrid"></div>
        </div>
    </div>

    <!-- 保存投注弹窗 -->
    <div id="saveModal" class="save-modal">
        <div class="save-content">
            <div class="save-header">
                <h3>💾 保存投注记录</h3>
                <span class="save-close" id="closeSaveBtn">&times;</span>
            </div>
            
            <div class="save-info">
                <div class="save-info-item">
                    <span class="label">累计总金额：</span>
                    <span class="value" id="saveAmount">¥0.00</span>
                </div>
                <div class="save-info-item">
                    <span class="label">投注号码数：</span>
                    <span class="value" id="saveNumbersCount">0</span>
                </div>
                <div class="save-info-item">
                    <span class="label">保存时间：</span>
                    <span class="value" id="saveTime"></span>
                </div>
            </div>
            
            <div class="save-input-area">
                <label for="saveRemark">备注信息：</label>
                <input type="text" id="saveRemark" placeholder="请输入备注（例如：张三的单子）">
            </div>
            
            <div class="save-actions">
                <button class="btn-cancel-save" id="cancelSaveBtn">取消</button>
                <button class="btn-save" id="confirmSaveBtn">确认保存</button>
            </div>
        </div>
    </div>

    <!-- 投注记录列表弹窗 -->
    <div id="historyModal" class="history-modal">
        <div class="history-content">
            <div class="history-header">
                <h3>📋 投注记录列表</h3>
                <span class="history-close" id="closeHistoryBtn">&times;</span>
            </div>
            
            <div class="history-stats">
                <div class="total-stats">
                    <div class="stat-item">
                        <div class="stat-label">总投注金额</div>
                        <div class="stat-value total" id="historyTotalAmount">0.00</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">投注次数</div>
                        <div class="stat-value count" id="historyCount">0</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">平均金额</div>
                        <div class="stat-value avg" id="historyAvgAmount">0.00</div>
                    </div>
                </div>
            </div>
            
            <div class="history-list">
                <div class="history-list-header">
                    <div>保存时间</div>
                    <div>总金额</div>
                    <div>号码数量</div>
                    <div>备注</div>
                    <div>操作</div>
                </div>
                <div class="history-list-body" id="historyListBody">
                    <!-- 动态生成保存记录 -->
                </div>
            </div>
            
            <div class="history-actions">
                <button class="btn-refresh" id="refreshHistoryBtn">🔄 刷新</button>
                <button class="btn-export" id="exportHistoryBtn">📥 导出数据</button>
                <button class="btn-clear-history" id="clearHistoryBtn">🗑️ 清除所有记录</button>
            </div>
        </div>
    </div>

    <!-- 投注详情弹窗 -->
    <div id="detailModal" class="detail-modal">
        <div class="detail-content">
            <div class="detail-header">
                <h4 id="detailTitle">投注详情</h4>
                <span class="detail-close" id="closeDetailBtn">&times;</span>
            </div>
            <div class="detail-info" id="detailInfo">
                <!-- 动态生成详情信息 -->
            </div>
            <div class="detail-numbers-grid" id="detailNumbers">
                <!-- 动态生成号码详情 -->
            </div>
        </div>
    </div>

    <!-- 确认清空弹窗 -->
    <div id="confirmModal" class="confirm-modal">
        <div class="confirm-content">
            <h4>⚠️ 确认清空</h4>
            <p id="confirmMessage">确定要清除所有投注记录吗？此操作不可恢复！</p>
            <div class="confirm-buttons">
                <button class="btn-confirm-yes" id="confirmYesBtn">确认清除</button>
                <button class="btn-confirm-no" id="confirmNoBtn">取消</button>
            </div>
        </div>
    </div>

    <!-- 识别弹窗 -->
    <div id="recognizeModal" class="recognize-modal">
        <div class="recognize-content">
            <div class="recognize-header">
                <h3>🔍 识别金额</h3>
                <span class="recognize-close" id="closeRecognizeBtn">&times;</span>
            </div>
            
            <div class="recognize-example">
                <p><strong>📝 支持的格式：</strong></p>
                <p>• 生肖格式：<code>虎马鼠羊兔牛各50</code> 或 <code>龙蛇猪各30</code> → 每个生肖的所有号码各50/30元</p>
                <p>• 号码列表格式：<code>05 13 56 75 34 23 45 36各50</code> 或 <code>05-13-56-75-34-23-45-36个50</code></p>
                <p>• 支持分隔符：点号(.)、减号(-)、中文句号(。)、斜杠(/)、空格</p>
                <p>• 金额关键词：支持 <code>个</code> 或 <code>各</code></p>
                <p>• 金额格式：支持数字或中文（一~十、二十、三十...一百）</p>
                <p><strong>💡 示例（可写在同一行或用换行分隔）：</strong></p>
                <p><code>虎马鼠羊兔牛各50</code></p>
                <p><code>龙蛇猪各30</code></p>
            </div>
            
            <div class="recognize-input-area">
                <textarea id="recognizeText" placeholder="请输入要识别的文本，支持多种分隔符和中文金额，多个规则可用换行分隔..."></textarea>
            </div>
            
            <div class="parse-result" id="parseResult">
                解析成功！已填充到对应输入框。
            </div>
            
            <div class="recognize-actions">
                <button class="btn-cancel" id="cancelRecognizeBtn">取消</button>
                <button class="btn-parse" id="parseBtn">开始识别</button>
            </div>
        </div>
    </div>

    <script>
        (function() {
            // 获取核心元素
            const reportBtn = document.getElementById('reportBtn');
            const clearOrderBtn = document.getElementById('clearOrderBtn');
            const clearAllBtn = document.getElementById('clearAllBtn');
            const reportTotal = document.getElementById('reportTotal');
            const accumulateTotal = document.getElementById('accumulateTotal');
            const orderTotal = document.getElementById('orderTotal');
            const scatterTotal = document.getElementById('scatterTotal');
            const amountInputs = document.querySelectorAll('.amount-input');
            const referenceBtn = document.getElementById('referenceBtn');
            const waveBtn = document.getElementById('waveBtn');
            const referenceModal = document.getElementById('referenceModal');
            const waveModal = document.getElementById('waveModal');
            const closeReferenceBtn = document.getElementById('closeReferenceBtn');
            const closeWaveBtn = document.getElementById('closeWaveBtn');
            const referenceGrid = document.getElementById('referenceGrid');
            const waveGrid = document.getElementById('waveGrid');

            // 保存记录相关元素
            const saveBtn = document.getElementById('saveBtn');
            const saveModal = document.getElementById('saveModal');
            const closeSaveBtn = document.getElementById('closeSaveBtn');
            const cancelSaveBtn = document.getElementById('cancelSaveBtn');
            const confirmSaveBtn = document.getElementById('confirmSaveBtn');
            const saveAmount = document.getElementById('saveAmount');
            const saveNumbersCount = document.getElementById('saveNumbersCount');
            const saveTime = document.getElementById('saveTime');
            const saveRemark = document.getElementById('saveRemark');

            // 历史记录相关元素
            const historyBtn = document.getElementById('historyBtn');
            const historyModal = document.getElementById('historyModal');
            const closeHistoryBtn = document.getElementById('closeHistoryBtn');
            const historyListBody = document.getElementById('historyListBody');
            const historyTotalAmount = document.getElementById('historyTotalAmount');
            const historyAvgAmount = document.getElementById('historyAvgAmount');
            const historyCount = document.getElementById('historyCount');
            const clearHistoryBtn = document.getElementById('clearHistoryBtn');
            const refreshHistoryBtn = document.getElementById('refreshHistoryBtn');
            const exportHistoryBtn = document.getElementById('exportHistoryBtn');

            // 详情弹窗
            const detailModal = document.getElementById('detailModal');
            const closeDetailBtn = document.getElementById('closeDetailBtn');
            const detailTitle = document.getElementById('detailTitle');
            const detailInfo = document.getElementById('detailInfo');
            const detailNumbers = document.getElementById('detailNumbers');

            // 识别相关元素
            const recognizeBtn = document.getElementById('recognizeBtn');
            const recognizeModal = document.getElementById('recognizeModal');
            const closeRecognizeBtn = document.getElementById('closeRecognizeBtn');
            const cancelRecognizeBtn = document.getElementById('cancelRecognizeBtn');
            const parseBtn = document.getElementById('parseBtn');
            const recognizeText = document.getElementById('recognizeText');
            const parseResult = document.getElementById('parseResult');

            // 确认弹窗
            const confirmModal = document.getElementById('confirmModal');
            const confirmYesBtn = document.getElementById('confirmYesBtn');
            const confirmNoBtn = document.getElementById('confirmNoBtn');
            const confirmMessage = document.getElementById('confirmMessage');

            // 累计存储对象（用于本单汇总）
            let numberAccum = {};
            let accumulateAmount = 0;

            // 保存记录存储 - 使用 localStorage
            let savedRecords = [];

            // 当前选中的记录ID（用于删除）
            let currentDeleteId = null;

            // 号码对应的生肖映射（从input的data-animal获取）
            const numberToAnimal = {};
            amountInputs.forEach(input => {
                const num = input.dataset.number;
                const animal = input.dataset.animal;
                numberToAnimal[num] = animal;
            });

            // 根据新波色表更新每个号码的波色
            const waveColors = {
                // 红波：01-02-07-08-12-13-18-19-23-24-29-30-34-35-40-45-46
                '01': 'red', '02': 'red', '07': 'red', '08': 'red', '12': 'red', '13': 'red', '18': 'red', '19': 'red',
                '23': 'red', '24': 'red', '29': 'red', '30': 'red', '34': 'red', '35': 'red', '40': 'red', '45': 'red', '46': 'red',
                // 蓝波：03-04-09-10-14-15-20-25-26-31-36-37-41-42-47-48
                '03': 'blue', '04': 'blue', '09': 'blue', '10': 'blue', '14': 'blue', '15': 'blue', '20': 'blue', '25': 'blue',
                '26': 'blue', '31': 'blue', '36': 'blue', '37': 'blue', '41': 'blue', '42': 'blue', '47': 'blue', '48': 'blue',
                // 绿波：05-06-11-16-17-21-22-27-28-32-33-38-39-43-44-49
                '05': 'green', '06': 'green', '11': 'green', '16': 'green', '17': 'green', '21': 'green', '22': 'green',
                '27': 'green', '28': 'green', '32': 'green', '33': 'green', '38': 'green', '39': 'green', '43': 'green', '44': 'green', '49': 'green'
            };

            // 生肖对应的号码映射
            const animalNumbers = {
                '鼠': ['07', '19', '31', '43'],
                '牛': ['06', '18', '30', '42'],
                '虎': ['05', '17', '29', '41'],
                '兔': ['04', '16', '28', '40'],
                '龙': ['03', '15', '27', '39'],
                '蛇': ['02', '14', '26', '38'],
                '马': ['01', '13', '25', '37', '49'],
                '羊': ['12', '24', '36', '48'],
                '猴': ['11', '23', '35', '47'],
                '鸡': ['10', '22', '34', '46'],
                '狗': ['09', '21', '33', '45'],
                '猪': ['08', '20', '32', '44']
            };

            // 根据animalNumbers生成animalData（用于汇总弹窗）
            const animalData = {};
            Object.entries(animalNumbers).forEach(([animal, numbers]) => {
                animalData[animal] = {
                    numbers: numbers,
                    colors: numbers.map(num => waveColors[num] || 'black')
                };
            });

            const animalOrder = ['鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪'];

            // 获取当前本地日期时间
            function getCurrentDateTime() {
                const now = new Date();
                const year = now.getFullYear();
                const month = String(now.getMonth() + 1).padStart(2, '0');
                const day = String(now.getDate()).padStart(2, '0');
                const hours = String(now.getHours()).padStart(2, '0');
                const minutes = String(now.getMinutes()).padStart(2, '0');
                const seconds = String(now.getSeconds()).padStart(2, '0');
                return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
            }

            // 实时计算本单汇总
            amountInputs.forEach(input => {
                input.addEventListener('input', calculateOrderTotal);
            });

            function calculateOrderTotal() {
                let total = 0;
                amountInputs.forEach(input => {
                    const value = parseFloat(input.value) || 0;
                    total += value;
                });
                orderTotal.textContent = total.toFixed(2);
                scatterTotal.textContent = total.toFixed(2);
            }

            // 获取当前累计的投注明细
            function getCurrentAccumDetails() {
                const details = {};
                let totalAmount = 0;
                let numbersCount = 0;
                
                Object.entries(numberAccum).forEach(([num, amount]) => {
                    if (amount > 0) {
                        details[num] = amount;
                        totalAmount += amount;
                        numbersCount++;
                    }
                });
                
                return { details, totalAmount, numbersCount };
            }

            // 清空累计数据
            function clearAccumulatedData() {
                numberAccum = {};
                accumulateAmount = 0;
                reportTotal.textContent = '0.00';
                accumulateTotal.textContent = '0.00';
            }

            // 加载保存记录
            function loadSavedRecords() {
                const saved = localStorage.getItem('savedRecords');
                if (saved) {
                    try {
                        savedRecords = JSON.parse(saved);
                    } catch (e) {
                        savedRecords = [];
                    }
                } else {
                    savedRecords = [];
                    saveRecords();
                }
            }

            // 保存记录到localStorage
            function saveRecords() {
                localStorage.setItem('savedRecords', JSON.stringify(savedRecords));
            }

            // 渲染保存记录列表
            function renderHistoryList() {
                // 按时间倒序排序
                const sortedRecords = [...savedRecords].sort((a, b) => 
                    new Date(b.time) - new Date(a.time)
                );
                
                let html = '';
                let totalAmount = 0;
                
                sortedRecords.forEach(record => {
                    totalAmount += record.totalAmount;
                    const numbersCount = Object.keys(record.details).length;
                    
                    html += `
                        <div class="history-item" onclick="window.showRecordDetail('${record.id}')">
                            <div class="date">${record.time}</div>
                            <div class="amount">¥ ${record.totalAmount.toFixed(2)}</div>
                            <div class="numbers-count">${numbersCount} 个号码</div>
                            <div class="remark">${record.remark || '无备注'}</div>
                            <div class="delete" onclick="event.stopPropagation(); window.confirmDeleteRecord('${record.id}')">删除</div>
                        </div>
                    `;
                });
                
                historyListBody.innerHTML = html || '<div style="text-align:center; padding:20px; color:#7f8c8d;">暂无投注记录</div>';
                
                // 更新统计
                const count = savedRecords.length;
                historyTotalAmount.textContent = totalAmount.toFixed(2);
                historyCount.textContent = count;
                historyAvgAmount.textContent = count > 0 ? (totalAmount / count).toFixed(2) : '0.00';
            }

            // 显示记录详情
            window.showRecordDetail = function(id) {
                const record = savedRecords.find(r => r.id === id);
                if (!record) return;
                
                detailTitle.textContent = `投注详情 - ${record.remark || '无备注'}`;
                
                // 详情信息
                const numbersCount = Object.keys(record.details).length;
                detailInfo.innerHTML = `
                    <div><strong>保存时间：</strong> ${record.time}</div>
                    <div><strong>总金额：</strong> ¥${record.totalAmount.toFixed(2)}</div>
                    <div><strong>号码数量：</strong> ${numbersCount} 个</div>
                    <div><strong>备注：</strong> ${record.remark || '无备注'}</div>
                `;
                
                // 号码详情 - 显示号码、生肖和金额
                let numbersHtml = '';
                const sortedNumbers = Object.keys(record.details).sort((a, b) => parseInt(a) - parseInt(b));
                sortedNumbers.forEach(num => {
                    const amount = record.details[num];
                    const color = waveColors[num] || 'black';
                    const animal = numberToAnimal[num] || '';
                    numbersHtml += `
                        <div class="detail-number-item ${color}">
                            <div class="num">${num}</div>
                            <div class="animal">${animal}</div>
                            <div class="val">¥${amount.toFixed(2)}</div>
                        </div>
                    `;
                });
                
                detailNumbers.innerHTML = numbersHtml;
                detailModal.style.display = 'flex';
            };

            // 确认删除记录
            window.confirmDeleteRecord = function(id) {
                currentDeleteId = id;
                confirmMessage.textContent = '确定要删除这条投注记录吗？此操作不可恢复！';
                confirmModal.style.display = 'flex';
            };

            // 执行删除
            function deleteRecord(id) {
                savedRecords = savedRecords.filter(r => r.id !== id);
                saveRecords();
                renderHistoryList();
                confirmModal.style.display = 'none';
            }

            // 清除所有记录
            function clearAllRecords() {
                savedRecords = [];
                saveRecords();
                renderHistoryList();
                confirmModal.style.display = 'none';
            }

            // 打开保存记录弹窗
            saveBtn.addEventListener('click', () => {
                const { details, totalAmount, numbersCount } = getCurrentAccumDetails();
                
                if (totalAmount <= 0) {
                    alert('当前累计金额为0，无需保存');
                    return;
                }
                
                saveAmount.textContent = `¥${totalAmount.toFixed(2)}`;
                saveNumbersCount.textContent = numbersCount;
                saveTime.textContent = getCurrentDateTime();
                saveRemark.value = '';
                saveModal.style.display = 'flex';
            });

            // 关闭保存记录弹窗
            function closeSaveModal() {
                saveModal.style.display = 'none';
            }

            closeSaveBtn.addEventListener('click', closeSaveModal);
            cancelSaveBtn.addEventListener('click', closeSaveModal);

            // 确认保存
            confirmSaveBtn.addEventListener('click', () => {
                const { details, totalAmount, numbersCount } = getCurrentAccumDetails();
                
                if (totalAmount <= 0) {
                    alert('当前累计金额为0，无需保存');
                    closeSaveModal();
                    return;
                }
                
                // 创建新记录
                const newRecord = {
                    id: Date.now().toString(),
                    time: getCurrentDateTime(),
                    totalAmount: totalAmount,
                    details: { ...details }, // 保存完整的投注明细
                    remark: saveRemark.value.trim() || '无备注'
                };
                
                savedRecords.push(newRecord);
                saveRecords();
                
                // 清空累计数据
                clearAccumulatedData();
                
                closeSaveModal();
                alert(`✅ 保存成功！总金额 ¥${totalAmount.toFixed(2)}，共 ${numbersCount} 个号码已保存到记录中，累计数据已清空。`);
            });

            // 打开历史记录弹窗
            historyBtn.addEventListener('click', () => {
                renderHistoryList();
                historyModal.style.display = 'flex';
            });

            // 关闭历史记录弹窗
            closeHistoryBtn.addEventListener('click', () => {
                historyModal.style.display = 'none';
            });

            // 关闭详情弹窗
            closeDetailBtn.addEventListener('click', () => {
                detailModal.style.display = 'none';
            });

            // 刷新历史记录
            refreshHistoryBtn.addEventListener('click', () => {
                renderHistoryList();
            });

            // 导出数据
            exportHistoryBtn.addEventListener('click', () => {
                const dataStr = JSON.stringify(savedRecords, null, 2);
                const blob = new Blob([dataStr], { type: 'application/json' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = `bet_records_${getCurrentDateTime().split(' ')[0]}.json`;
                a.click();
                URL.revokeObjectURL(url);
            });

            // 清除所有记录按钮
            clearHistoryBtn.addEventListener('click', () => {
                if (savedRecords.length === 0) {
                    alert('暂无保存记录');
                    return;
                }
                confirmMessage.textContent = '确定要清除所有投注记录吗？此操作不可恢复！';
                currentDeleteId = 'ALL';
                confirmModal.style.display = 'flex';
            });

            // 确认弹窗按钮
            confirmYesBtn.addEventListener('click', () => {
                if (currentDeleteId === 'ALL') {
                    clearAllRecords();
                } else {
                    deleteRecord(currentDeleteId);
                }
            });

            confirmNoBtn.addEventListener('click', () => {
                confirmModal.style.display = 'none';
                currentDeleteId = null;
            });

            // 一键上报
            reportBtn.addEventListener('click', function() {
                calculateOrderTotal();
                const currentAmount = parseFloat(orderTotal.textContent) || 0;
                if (currentAmount <= 0) {
                    alert('本次无有效金额，无需上报！');
                    return;
                }

                // 更新累计金额
                amountInputs.forEach(input => {
                    const num = input.dataset.number;
                    const val = parseFloat(input.value) || 0;
                    if (val > 0) {
                        if (!numberAccum[num]) numberAccum[num] = 0;
                        numberAccum[num] += val;
                    }
                });

                accumulateAmount = Object.values(numberAccum).reduce((sum, v) => sum + v, 0);
                reportTotal.textContent = currentAmount.toFixed(2);
                accumulateTotal.textContent = accumulateAmount.toFixed(2);

                // 清空输入框
                amountInputs.forEach(input => { input.value = ''; });
                calculateOrderTotal();

                alert(`✅ 一键上报成功！本次上报 ¥${currentAmount.toFixed(2)} 已累计。`);
            });

            // 清空本单汇总
            clearOrderBtn.addEventListener('click', function() {
                if (confirm('确定要清空本单所有输入的金额吗？')) {
                    amountInputs.forEach(input => { input.value = ''; });
                    calculateOrderTotal();
                }
            });

            // 清空累计数据
            clearAllBtn.addEventListener('click', function() {
                if (confirm('确定要清空所有累计上报数据吗？本单输入的金额不会清空')) {
                    numberAccum = {};
                    accumulateAmount = 0;
                    reportTotal.textContent = '0.00';
                    accumulateTotal.textContent = '0.00';
                    alert('累计上报数据已清空！');
                }
            });

            // 初始化
            calculateOrderTotal();
            reportTotal.textContent = '0.00';
            accumulateTotal.textContent = '0.00';
            loadSavedRecords();

            // 生肖参照弹窗
            function renderReference() {
                let html = '';
                animalOrder.forEach(animal => {
                    const data = animalData[animal];
                    html += `<div class="ref-item ${animal}">`;
                    html += `<div class="ref-title">🐾 ${animal}</div>`;
                    html += `<div class="ref-numbers">`;
                    
                    data.numbers.forEach((num, index) => {
                        const color = data.colors[index];
                        const colorClass = color === 'red' ? 'red' : (color === 'blue' ? 'blue' : 'green');
                        html += `
                            <div class="ref-number-row">
                                <span class="ref-number-value ${colorClass}">${num}</span>
                            </div>
                        `;
                    });
                    
                    html += `</div></div>`;
                });
                referenceGrid.innerHTML = html;
            }

            referenceBtn.addEventListener('click', () => {
                renderReference();
                referenceModal.style.display = 'flex';
            });

            closeReferenceBtn.addEventListener('click', () => {
                referenceModal.style.display = 'none';
            });

            // 波色参照弹窗
            function renderWave() {
                const waveGroups = {
                    'red': [],
                    'blue': [],
                    'green': []
                };
                
                Object.entries(waveColors).forEach(([num, color]) => {
                    waveGroups[color].push(num);
                });

                waveGroups.red.sort((a, b) => parseInt(a) - parseInt(b));
                waveGroups.blue.sort((a, b) => parseInt(a) - parseInt(b));
                waveGroups.green.sort((a, b) => parseInt(a) - parseInt(b));

                let html = `
                    <div class="wave-section red-section">
                        <div class="wave-section-title red">🔴 红波</div>
                        <div class="wave-numbers-grid">
                `;
                waveGroups.red.forEach(num => {
                    html += `<div class="wave-number-item red">${num}</div>`;
                });
                html += `</div></div>`;

                html += `
                    <div class="wave-section blue-section">
                        <div class="wave-section-title blue">🔵 蓝波</div>
                        <div class="wave-numbers-grid">
                `;
                waveGroups.blue.forEach(num => {
                    html += `<div class="wave-number-item blue">${num}</div>`;
                });
                html += `</div></div>`;

                html += `
                    <div class="wave-section green-section">
                        <div class="wave-section-title green">🟢 绿波</div>
                        <div class="wave-numbers-grid">
                `;
                waveGroups.green.forEach(num => {
                    html += `<div class="wave-number-item green">${num}</div>`;
                });
                html += `</div></div>`;

                waveGrid.innerHTML = html;
            }

            waveBtn.addEventListener('click', () => {
                renderWave();
                waveModal.style.display = 'flex';
            });

            closeWaveBtn.addEventListener('click', () => {
                waveModal.style.display = 'none';
            });

            // 点击外部关闭弹窗
            window.addEventListener('click', (e) => {
                if (e.target === referenceModal) {
                    referenceModal.style.display = 'none';
                }
                if (e.target === waveModal) {
                    waveModal.style.display = 'none';
                }
                if (e.target === historyModal) {
                    historyModal.style.display = 'none';
                }
                if (e.target === detailModal) {
                    detailModal.style.display = 'none';
                }
                if (e.target === confirmModal) {
                    confirmModal.style.display = 'none';
                }
                if (e.target === recognizeModal) {
                    recognizeModal.style.display = 'none';
                }
                if (e.target === saveModal) {
                    saveModal.style.display = 'none';
                }
            });

            // 汇总弹窗相关
            const summaryBtn = document.getElementById('summaryBtn');
            const modal = document.getElementById('summaryModal');
            const closeModalBtn = document.getElementById('closeModalBtn');
            const sortSelect = document.getElementById('sortSelect');
            const applyFilterBtn = document.getElementById('applyFilterBtn');
            const numbersView = document.getElementById('numbersView');
            const animalsView = document.getElementById('animalsView');
            const viewNumbersBtn = document.getElementById('viewNumbersBtn');
            const viewAnimalsBtn = document.getElementById('viewAnimalsBtn');
            const numbersGrid = document.getElementById('numbersGrid');
            const animalsGrid = document.getElementById('animalsGrid');
            const modalAccumTotal = document.getElementById('modalAccumTotal');

            let currentView = 'numbers';

            const allNumbers = [];
            const numberSet = new Set();
            amountInputs.forEach(input => {
                const num = input.dataset.number;
                if (!numberSet.has(num)) {
                    numberSet.add(num);
                    allNumbers.push({
                        number: num,
                        animal: input.dataset.animal
                    });
                }
            });
            allNumbers.sort((a, b) => parseInt(a.number) - parseInt(b.number));

            function closeModal() {
                modal.style.display = 'none';
            }
            closeModalBtn.addEventListener('click', closeModal);
            window.addEventListener('click', (e) => {
                if (e.target === modal) closeModal();
            });

            viewNumbersBtn.addEventListener('click', () => {
                viewNumbersBtn.classList.add('active');
                viewAnimalsBtn.classList.remove('active');
                numbersView.style.display = 'block';
                animalsView.style.display = 'none';
                currentView = 'numbers';
                renderCurrentView();
            });

            viewAnimalsBtn.addEventListener('click', () => {
                viewAnimalsBtn.classList.add('active');
                viewNumbersBtn.classList.remove('active');
                animalsView.style.display = 'block';
                numbersView.style.display = 'none';
                currentView = 'animals';
                renderCurrentView();
            });

            // 计算生肖累计
            function calculateAnimalTotals() {
                const animalTotals = {};
                animalOrder.forEach(animal => { animalTotals[animal] = 0; });

                Object.entries(numberAccum).forEach(([number, amount]) => {
                    for (const [animal, data] of Object.entries(animalData)) {
                        if (data.numbers.includes(number)) {
                            animalTotals[animal] += amount;
                            break;
                        }
                    }
                });
                return animalTotals;
            }

            // 渲染当前视图
            function renderCurrentView() {
                if (currentView === 'numbers') {
                    renderNumbersView();
                } else {
                    renderAnimalsView();
                }
            }

            // 渲染号码视图
            function renderNumbersView() {
                const sortOrder = sortSelect.value;
                
                let items = allNumbers.map(item => ({
                    number: item.number,
                    animal: item.animal,
                    amount: numberAccum[item.number] || 0
                }));

                if (sortOrder === 'desc') {
                    items.sort((a, b) => b.amount - a.amount);
                } else if (sortOrder === 'asc') {
                    items.sort((a, b) => a.amount - b.amount);
                } else if (sortOrder === 'animalOrder') {
                    items.sort((a, b) => {
                        if (a.animal === b.animal) {
                            return parseInt(a.number) - parseInt(b.number);
                        }
                        return animalOrder.indexOf(a.animal) - animalOrder.indexOf(b.animal);
                    });
                } else {
                    items.sort((a, b) => parseInt(a.number) - parseInt(b.number));
                }

                const amounts = items.map(i => i.amount).filter(v => v > 0);
                const maxVal = amounts.length ? Math.max(...amounts) : -1;
                const minVal = amounts.length ? Math.min(...amounts) : -1;

                let html = '';
                items.forEach(item => {
                    const amount = item.amount;
                    let highlightClass = '';
                    if (amount > 0 && amount === maxVal && maxVal !== minVal) highlightClass = 'highlight-max';
                    else if (amount > 0 && amount === minVal && maxVal !== minVal) highlightClass = 'highlight-min';
                    
                    html += `
                        <div class="number-card ${highlightClass}">
                            <div class="number-header">
                                <span class="number-badge">${item.number}</span>
                                <span class="animal-tag">${item.animal}</span>
                            </div>
                            <div class="amount-display">¥ ${amount.toFixed(2)}</div>
                        </div>
                    `;
                });
                numbersGrid.innerHTML = html;

                const total = items.reduce((sum, i) => sum + i.amount, 0);
                modalAccumTotal.textContent = total.toFixed(2);
            }

            // 渲染生肖视图
            function renderAnimalsView() {
                const sortOrder = sortSelect.value;
                const animalTotals = calculateAnimalTotals();
                
                let animals = Object.entries(animalTotals).map(([animal, amount]) => ({
                    animal,
                    amount,
                    numbers: animalData[animal].numbers
                }));

                if (sortOrder === 'desc') {
                    animals.sort((a, b) => b.amount - a.amount);
                } else if (sortOrder === 'asc') {
                    animals.sort((a, b) => a.amount - b.amount);
                } else {
                    animals.sort((a, b) => animalOrder.indexOf(a.animal) - animalOrder.indexOf(b.animal));
                }

                const amounts = animals.map(a => a.amount).filter(v => v > 0);
                const maxVal = amounts.length ? Math.max(...amounts) : -1;
                const minVal = amounts.length ? Math.min(...amounts) : -1;

                let html = '';
                animals.forEach(item => {
                    const amount = item.amount;
                    let highlightClass = '';
                    if (amount > 0 && amount === maxVal && maxVal !== minVal) highlightClass = 'highlight-max';
                    else if (amount > 0 && amount === minVal && maxVal !== minVal) highlightClass = 'highlight-min';
                    
                    html += `
                        <div class="animal-card ${highlightClass}">
                            <div class="animal-icon">🐾</div>
                            <div class="animal-name">${item.animal}</div>
                            <div class="animal-amount">¥ ${amount.toFixed(2)}</div>
                            <div class="animal-numbers">${item.numbers.join(' ')}</div>
                        </div>
                    `;
                });
                animalsGrid.innerHTML = html;

                const total = animals.reduce((sum, i) => sum + i.amount, 0);
                modalAccumTotal.textContent = total.toFixed(2);
            }

            summaryBtn.addEventListener('click', () => {
                renderCurrentView();
                modal.style.display = 'flex';
            });

            applyFilterBtn.addEventListener('click', renderCurrentView);

            // 识别功能
            // 中文数字转阿拉伯数字
            function chineseToNumber(chinese) {
                if (!isNaN(parseFloat(chinese))) {
                    return parseFloat(chinese);
                }
                
                const chineseNumbers = {
                    '一': 1, '二': 2, '三': 3, '四': 4, '五': 5, '六': 6, '七': 7, '八': 8, '九': 9, '十': 10,
                    '十一': 11, '十二': 12, '十三': 13, '十四': 14, '十五': 15, '十六': 16, '十七': 17, '十八': 18, '十九': 19,
                    '二十': 20, '二十一': 21, '二十二': 22, '二十三': 23, '二十四': 24, '二十五': 25, '二十六': 26, '二十七': 27, '二十八': 28, '二十九': 29,
                    '三十': 30, '三十一': 31, '三十二': 32, '三十三': 33, '三十四': 34, '三十五': 35, '三十六': 36, '三十七': 37, '三十八': 38, '三十九': 39,
                    '四十': 40, '四十一': 41, '四十二': 42, '四十三': 43, '四十四': 44, '四十五': 45, '四十六': 46, '四十七': 47, '四十八': 48, '四十九': 49,
                    '五十': 50, '五十一': 51, '五十二': 52, '五十三': 53, '五十四': 54, '五十五': 55, '五十六': 56, '五十七': 57, '五十八': 58, '五十九': 59,
                    '六十': 60, '六十一': 61, '六十二': 62, '六十三': 63, '六十四': 64, '六十五': 65, '六十六': 66, '六十七': 67, '六十八': 68, '六十九': 69,
                    '七十': 70, '七十一': 71, '七十二': 72, '七十三': 73, '七十四': 74, '七十五': 75, '七十六': 76, '七十七': 77, '七十八': 78, '七十九': 79,
                    '八十': 80, '八十一': 81, '八十二': 82, '八十三': 83, '八十四': 84, '八十五': 85, '八十六': 86, '八十七': 87, '八十八': 88, '八十九': 89,
                    '九十': 90, '九十一': 91, '九十二': 92, '九十三': 93, '九十四': 94, '九十五': 95, '九十六': 96, '九十七': 97, '九十八': 98, '九十九': 99,
                    '一百': 100
                };
                
                if (chineseNumbers[chinese] !== undefined) {
                    return chineseNumbers[chinese];
                }
                
                return NaN;
            }

            // 验证是否是有效的号码
            function isValidNumber(num) {
                if (!/^\d{1,2}$/.test(num)) return false;
                const numInt = parseInt(num, 10);
                return numInt >= 1 && numInt <= 49;
            }

            // 格式化号码为两位数字符串
            function formatNumber(num) {
                const numInt = parseInt(num, 10);
                return numInt < 10 ? '0' + numInt : numInt.toString();
            }

            // 解析一行文本
            function parseLine(line) {
                const results = {};
                
                const match = line.match(/(.+?)(?:个|各)(.+)/);
                if (!match) return results;
                
                const leftPart = match[1].trim();
                const amountStr = match[2].trim();
                
                let amount = parseFloat(amountStr);
                if (isNaN(amount)) {
                    amount = chineseToNumber(amountStr);
                }
                
                if (isNaN(amount) || amount <= 0) return results;
                
                const animalPattern = /^[鼠牛虎兔龙蛇马羊猴鸡狗猪]+$/;
                
                if (animalPattern.test(leftPart)) {
                    const animals = leftPart.split('');
                    animals.forEach(animal => {
                        const numbers = animalNumbers[animal];
                        if (numbers) {
                            numbers.forEach(num => {
                                if (!results[num]) results[num] = 0;
                                results[num] += amount;
                            });
                        }
                    });
                } else {
                    let normalized = leftPart
                        .replace(/[.\-。\/\s]+/g, ' ')
                        .trim();
                    
                    if (!normalized) return results;
                    
                    const numberList = normalized.split(/\s+/);
                    
                    numberList.forEach(numStr => {
                        let num = numStr.trim();
                        if (!num) return;
                        
                        if (isValidNumber(num)) {
                            const formattedNum = formatNumber(num);
                            if (!results[formattedNum]) results[formattedNum] = 0;
                            results[formattedNum] += amount;
                        }
                    });
                }
                
                return results;
            }

            // 解析文本
            function parseText(text) {
                const results = {};
                
                const lines = text.split('\n');
                
                lines.forEach(line => {
                    line = line.trim();
                    if (!line) return;
                    
                    const parts = line.split(/\s+/);
                    
                    parts.forEach(part => {
                        if (!part) return;
                        
                        if (part.includes('个') || part.includes('各')) {
                            const lineResults = parseLine(part);
                            
                            Object.entries(lineResults).forEach(([num, val]) => {
                                if (!results[num]) results[num] = 0;
                                results[num] += val;
                            });
                        }
                    });
                });
                
                return results;
            }

            // 填充到输入框
            function fillAmounts(results) {
                let filledCount = 0;
                let totalAmount = 0;
                
                amountInputs.forEach(input => {
                    const num = input.dataset.number;
                    if (results[num]) {
                        const currentVal = parseFloat(input.value) || 0;
                        const newVal = currentVal + results[num];
                        input.value = newVal.toFixed(2);
                        filledCount++;
                        totalAmount += results[num];
                    }
                });
                
                calculateOrderTotal();
                
                return { filledCount, totalAmount };
            }

            // 打开识别弹窗
            recognizeBtn.addEventListener('click', () => {
                recognizeText.value = '';
                parseResult.classList.remove('show');
                recognizeModal.style.display = 'flex';
            });

            // 关闭识别弹窗
            function closeRecognizeModal() {
                recognizeModal.style.display = 'none';
            }

            closeRecognizeBtn.addEventListener('click', closeRecognizeModal);
            cancelRecognizeBtn.addEventListener('click', closeRecognizeModal);

            // 解析按钮点击
            parseBtn.addEventListener('click', () => {
                const text = recognizeText.value.trim();
                if (!text) {
                    alert('请输入要识别的文本');
                    return;
                }
                
                const results = parseText(text);
                
                if (Object.keys(results).length === 0) {
                    alert('未能识别出任何有效数据，请检查格式');
                    return;
                }
                
                const { filledCount, totalAmount } = fillAmounts(results);
                
                parseResult.textContent = `✅ 识别成功！共填充 ${filledCount} 个号码，总金额 ¥${totalAmount.toFixed(2)}`;
                parseResult.classList.add('show');
            });
        })();
    </script>
</body>
</html>
