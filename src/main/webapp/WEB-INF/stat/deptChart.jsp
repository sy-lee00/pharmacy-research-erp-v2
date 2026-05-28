<div class="deptChart">
<canvas id="deptChart"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
<script>
Chart.register(ChartDataLabels);

$(function() {
    $.ajax({
        url: '/deptChart/data',
        type: 'GET',
        success: function(data) {
            const labels = data.map(d => d.deptName);
            const counts = data.map(d => d.cnt);
            const colors = [
                'rgba(164, 25, 61, 0.1)',
                'rgba(164, 25, 61, 0.2)',
                'rgba(164, 25, 61, 0.3)',
                'rgba(164, 25, 61, 0.4)',
                'rgba(164, 25, 61, 0.5)',
                'rgba(164, 25, 61, 0.6)',
                'rgba(164, 25, 61, 0.7)',
                'rgba(164, 25, 61, 0.8)',
                'rgba(164, 25, 61, 0.9)',
                'rgba(10, 25, 151, 0.7)',
                'rgba(10, 25, 151, 0.6)',
                'rgba(10, 25, 151, 0.5)',
                'rgba(10, 25, 151, 0.4)',
                'rgba(10, 25, 151, 0.3)',
                'rgba(10, 25, 151, 0.2)',
            ];

            const ctx = document.getElementById('deptChart').getContext('2d');
            new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '부서별 인원',
                        data: counts,
                        backgroundColor: colors
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            callbacks: {
                                title: function(tooltipItems) {
                                    return tooltipItems[0].label;
                                },
                                label: function(tooltipItem) {
                                    return tooltipItem.raw;
                                }
                            }
                        },
                        datalabels: {
                            color: '#0007',
                            formatter: function(value, context) {
                                const label = context.chart.data.labels[context.dataIndex];
                                return label;
                            },
                            font: { weight: 'normal' },
                            anchor: 'end',
                            align: 'start',
                            offset: 10
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false, drawOnChartArea: false, drawTicks: false },
                            ticks: { display: false }
                        },
                        y: {
                            grid: { display: false, drawOnChartArea: false, drawTicks: false },
                            ticks: { display: false }
                        }
                    }
                }
            });
        },
        error: function(err) {
        }
    });
});
</script>