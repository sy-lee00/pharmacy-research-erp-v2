<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ERP</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  </head>

  <body>
	<div style="width: 70%; margin: auto;">
	    <canvas id="approvalStatusChart"></canvas>
	</div>
    <script>
		$(function() {
		    $.ajax({
		        url: '/approval/chart-data', // API 주소는 확인 필요
		        type: 'get',
		        success: function(dataFromServer) {
		            
		            // 1. 전체 상태 목록과 기본값(0)을 미리 정의
		            const allStatuses = {
		                '전체': 0,
		                '대기': 0,
		                '승인': 0,
		                '반려': 0
		            };

		            // 2. 서버에서 받은 데이터로 값을 업데이트하고, '전체' 개수를 계산
		            let total = 0;
		            dataFromServer.forEach(item => {
		                if (allStatuses.hasOwnProperty(item.status)) {
		                    allStatuses[item.status] = item.count;
		                    total += item.count;
		                }
		            });
		            allStatuses['전체'] = total;

		            // 3. Chart.js에 사용할 데이터로 변환
		            const labels = Object.keys(allStatuses);
		            const counts = Object.values(allStatuses);

		            // 4. Chart.js로 세로 막대 그래프 생성
		            const ctx = document.getElementById('approvalStatusChart').getContext('2d');
		            new Chart(ctx, {
		                type: 'bar', // 차트 종류
		                data: {
		                    labels: labels,
		                    datasets: [{
		                        label: '승인 상태별 건수',
		                        data: counts,
		                        backgroundColor: [
		                            'rgba(108, 117, 125, 0.7)', // 전체
		                            'rgba(255, 206, 86, 0.7)', // 대기
		                            'rgba(54, 162, 235, 0.7)', // 승인
		                            'rgba(255, 99, 132, 0.7)'   // 반려
		                        ],
								borderColor: [
				                    'rgba(108, 117, 125, 1)',
				                    'rgba(255, 206, 86, 1)',
				                    'rgba(54, 162, 235, 1)',
				                    'rgba(255, 99, 132, 1)'
				                ],
				                borderWidth: 1,
		                    }]
		                },
		                options: {
		                    responsive: true,
		                    plugins: {
		                        legend: { display: false }
		                    },
		                    scales: {
		                        y: { // y축(세로)이 이제 값을 나타냅니다.
		                            beginAtZero: true,
		                            ticks: { stepSize: 1 }
		                        }
		                    }
		                }
		            });
		        },
		        error: function(error) {
		            console.error("차트 데이터를 불러오는 데 실패했습니다.", error);
		        }
		    });
		});
    </script>
  </body>
</html>