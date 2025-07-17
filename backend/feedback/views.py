from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json

feedback_list = []

@csrf_exempt
def feedback_api(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        feedback = {
            'name': data.get('name'),
            'message': data.get('message')
        }
        feedback_list.append(feedback)
        return JsonResponse({'status': 'success', 'data': feedback}, status=201)
    return JsonResponse({'feedback': feedback_list})