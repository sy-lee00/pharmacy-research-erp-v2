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
    <div style="width: 100%; height: 90%; padding: 5px; margin: 0">
      <canvas id="chemicalChart" style="margin-left: 95px"></canvas>
    </div>

    <div class="chart-pagination">
      <button id="prevPage" class="btn btn-outline-secondary">◀</button>
      <span id="chartPageInfo"></span>
      <button id="nextPage" class="btn btn-outline-secondary">▶</button>
    </div>
    <style>
      .btn {
        display: inline-block;
        padding: 0.6rem 1.2rem;
        font-size: 1rem;
        font-weight: 600;
        text-align: center;
        text-decoration: none; /* a 태그일 경우 밑줄 제거 */
        vertical-align: middle;
        cursor: pointer;

        border: 1px solid transparent;
        border-radius: 0.25rem;

        transition: all 0.2s ease-in-out; /* 부드러운 전환 효과 */
      }

      /* 회색 버튼 스타일 */
      .btn-secondary {
        color: #555;
        background-color: transparent;
        border-color: lightgrey;
      }

      /* 마우스를 올렸을 때 */
      .btn-secondary:hover {
        background-color: #5a6268;
        border-color: #545b62;
      }
      .chart-pagination .btn {
        padding: 0.3rem 0.8rem; /* 버튼의 상하, 좌우 여백을 줄임 */
        font-size: 0.9rem; /* 폰트 크기를 살짝 줄임 */
        font-weight: normal; /* 폰트 굵기를 보통으로 */
      }
    </style>
    <script>
      $(function () {
        // --- 페이징을 위한 전역 변수 선언 ---
        let chemicalChart; // 차트 객체를 저장할 변수
        let allLabels = [],
		  allNames = [],
          allStockData = [],
          allUsedData = []; // 전체 데이터를 저장할 배열
        let currentPage = 0;
        const pageSize = 20; // 한 페이지에 10개씩 표시

        // --- 특정 페이지의 차트를 그리는 함수 ---
        function drawChart(page) {
          const totalPages = Math.ceil(allLabels.length / pageSize);
          currentPage = page;

          // 1. 전체 데이터에서 현재 페이지에 해당하는 부분만 잘라냅니다.
          const start = page * pageSize;
          const end = start + pageSize;
          const pageLabels = allLabels.slice(start, end);
          const pageStockData = allStockData.slice(start, end);
          const pageUsedData = allUsedData.slice(start, end);

          // 2. 페이지 정보 텍스트를 업데이트합니다.
          $("#chartPageInfo").text();

          // 3. 이전/다음 버튼 활성화/비활성화 처리
          $("#prevPage").prop("disabled", currentPage === 0);
          $("#nextPage").prop("disabled", currentPage >= totalPages - 1);

          // 4. 차트 그리기
          const chartData = {
            labels: pageLabels,
            datasets: [
              {
                label: "현재 재고량",
                data: pageStockData,
                backgroundColor: "rgba(54, 162, 235, 0.5)",
              },
              {
                label: "총 사용량",
                data: pageUsedData,
                backgroundColor: "rgba(54, 162, 235, 1)",
              },
            ],
          };

          // 차트가 이미 그려져 있다면 데이터만 업데이트하고, 없다면 새로 그립니다.
          if (chemicalChart) {
            chemicalChart.data = chartData;
            chemicalChart.update();
          } else {
            const ctx = document
              .getElementById("chemicalChart")
              .getContext("2d");
            chemicalChart = new Chart(ctx, {
              type: "line",
              data: chartData,
              options: {
                responsive: true,
                plugins: {
                  legend: {
                    position: "top", // 범례 위치
                  },
				  tooltip: {
		            callbacks: {
		              title: function (tooltipItems) {
		                // tooltipItems 배열의 첫 번째 항목에서 정보 가져오기
		                const tooltipItem = tooltipItems[0];
		                // 현재 데이터의 인덱스(0, 1, 2...)
		                const dataIndex = tooltipItem.dataIndex;
		                // 미리 저장해둔 allNames 배열에서 해당 인덱스의 이름을 반환
		                return allNames[dataIndex];
		              },
		            },
		          },
                  datalabels: {
                      display: false
                  }
                },
                scales: {
                  x: {
                    stacked: false, // x축 쌓기
                  },
                  y: {
                    stacked: false, // y축 쌓기
                    beginAtZero: true,
                  },
                },
              },
            });
          }
        }

        // --- AJAX로 전체 데이터 불러오기 ---
        $.ajax({
          url: "/chemical/chart-data",
          type: "GET",
          success: function (data) {
            data.forEach((item) => {
              allLabels.push(item.chemicalId);
			  allNames.push(item.chemicalName);
              allStockData.push(item.stockQty);
              allUsedData.push(item.usedQty);
            });

            // 데이터 로딩 후 첫 페이지(0)의 차트를 그립니다.
            drawChart(0);
          },
          error: function (error) {
            console.error("차트 데이터를 불러오는 데 실패했습니다.", error);
          },
        });

        // --- 버튼 클릭 이벤트 핸들러 ---
        $("#prevPage").on("click", function () {
          if (currentPage > 0) {
            drawChart(currentPage - 1);
          }
        });

        $("#nextPage").on("click", function () {
          const totalPages = Math.ceil(allLabels.length / pageSize);
          if (currentPage < totalPages - 1) {
            drawChart(currentPage + 1);
          }
        });
      });
    </script>
  </body>
</html>
