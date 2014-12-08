datasources: {
  'eu-metrics': {
    type: 'influxdb',
    url: 'http://localhost:8086/db/metrics',
    username: 'test',
    password: 'test',
  },
  'grafana': {
    type: 'influxdb',
    url: 'http://my_influxdb_server:8086/db/grafana',
    username: 'test',
    password: 'test',
    grafanaDB: true
  },
},
