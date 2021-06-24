import json
import requests

NUMBER_OF_TASKS = 3
PREFETCH_COUNT_VALUE = 1000

def test_prefetch_count_being_set():

    url = 'http://localhost:15672/api/queues/%2f/source_queue'
    request_content = requests.get(url, auth=('guest', 'guest')).content
    queue_info_dict = serialize_json(request_content)
    tasks = queue_info_dict['consumer_details']

    assert len(tasks) == NUMBER_OF_TASKS
    for task in tasks:
        assert task['prefetch_count'] == PREFETCH_COUNT_VALUE

def serialize_json(byte_array_content):
    return json.loads(byte_array_content.decode('utf8'))
