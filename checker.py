import sys, json, requests, time
from datetime import datetime
from csv import writer

csvHeader = ['CPU(%)', 'Memory(MiB)']
usageList = []
serviceName = sys.argv[1]
currentTime = datetime.now().strftime('%Y-%m-%d-%H-%M-%S')
fileName = 'log/' + serviceName + '-' + currentTime + '.csv'

# Add header to .csv file
with open(fileName, 'w', encoding='UTF8') as f_object:
    writer_object = writer(f_object)
    writer_object.writerow(csvHeader)
    f_object.close()

# Write CPU and Memory records to .csv file
for i in range(int(sys.argv[2])):
    usageList.clear()
    cpuUsage = requests.get(
        "http://localhost:9090/api/v1/query?query=avg(irate(container_cpu_usage_seconds_total{container_label_com_docker_compose_service=%22"
        + serviceName + "%22}[5s]))*100")
    memoryUsage = requests.get(
        "http://localhost:9090/api/v1/query?query=avg(container_memory_working_set_bytes{container_label_com_docker_compose_service=%22"
        + serviceName + "%22})/1.049e%2B6")

    cpuUsage = json.loads(cpuUsage.text)["data"]["result"][0]["value"][1]
    memoryUsage = json.loads(memoryUsage.text)["data"]["result"][0]["value"][1]

    usageList.append(cpuUsage)
    usageList.append(memoryUsage)

    with open(fileName, 'a', encoding='UTF8') as f_object:
        writer_object = writer(f_object)
        writer_object.writerow(usageList)
        f_object.close()

    time.sleep(1.1)
