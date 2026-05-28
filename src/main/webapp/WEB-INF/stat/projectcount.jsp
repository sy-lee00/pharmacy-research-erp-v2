<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ERP</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.5.0/dist/chart.umd.min.js"></script>
</head>

<canvas id="projectChart"></canvas>
    
<script>
    const countPlan = ${countPlan};
    const countIng = ${countIng};
    const countDone = ${countDone};
    const countSum = countPlan + countIng + countDone; // 총합

    // 페이지 로딩 후 차트를 생성합니다.
    window.onload = function() {
        createProjectChart();
    };

    function createProjectChart() {
        const ctx = document.getElementById('projectChart').getContext('2d');
        
     // JSTL로 계산된 동적 데이터 사용
        const data = {
            labels: ['전체', '계획', '진행', '완료'],
            datasets: [{
                label: '프로젝트 수',
                data: [countSum, countPlan, countIng, countDone],
                backgroundColor: [
                    'rgba(110, 89, 219, 0.7)',  // 전체 - 보라 계열 (신뢰감)
                    'rgba(255, 99, 132, 0.7)',  // 계획 - 붉은 계열 (시작, 중요성)
                    'rgba(54, 162, 235, 0.7)',  // 진행 - 파랑 계열 (안정, 진행)
                    'rgba(75, 192, 192, 0.7)'   // 완료 - 청록 계열 (성공, 완료)
                ],
                borderColor: [
                    'rgba(110, 89, 219, 0.8)',
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(75, 192, 192, 1)'
                ],
                borderWidth: 1
            }]
        };

        // 옵션
        const options = {
        	indexAxis: 'y', // 이 속성을 추가하여 가로 막대 그래프로 변경
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                x: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '프로젝트 수'
                    },
                    ticks: {
                        stepSize: 1
                    }
                },
                 y: {
                    title: {
                        display: true,
                        text: '상태'
                    }
                }
            },
            plugins: {
                legend: {
                    display: false // 범례 숨기기
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                label += context.parsed.x + ' 건';
                            }
                            return label;
                        }
                    }
                },
                datalabels: {
                    display: false // 데이터 라벨(수치) 숨기기
                }
            },
        
 	    // ** onClick 이벤트 추가 **
        onClick: (event, elements) => {
            if (elements.length > 0) {
                const clickedIndex = elements[0].index;
                let redirectUrl = '';

                switch(clickedIndex) {
                    case 0:
                        // '전체' 클릭 시 이동할 URL
                        redirectUrl = '/project/list?select=status&search=';
                        break;
                    case 1:
                        // '계획' 클릭 시 이동할 URL
                        redirectUrl = '/project/list?select=status&search=계획중';
                        break;
                    case 2:
                        // '진행' 클릭 시 이동할 URL
                        redirectUrl = '/project/list?select=status&search=진행중';
                        break;
                    case 3:
                        // '완료' 클릭 시 이동할 URL
                        redirectUrl = '/project/list?select=status&search=완료';
                        break;
                }

                if (redirectUrl) {
                    window.location.href = redirectUrl;
                }
            }
        }
    };        
        // 차트 생성
        const myChart = new Chart(ctx, {
            type: 'bar', // 막대 그래프
            data: data,
            options: options
        });
    }
    
    </script>
    
</body>
</html>
