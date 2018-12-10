install packages 
	1. Open the command prompt in the directory in which you've extracted the project.
	2. Run "pip install matplotlib"
	3.Run "pip install numpy"
	4. Run "pip install ."
	5. Run "pip install tensorflow"
	
The following model of a retinanet based on a backbone of resent-50 is trained to perfom object detection on the eiffel tower, colloseum, golden gate bridge, leaning tower of pisa, tower bridge and arc de triomphe. It is adapted fromu/fizyr's implementaion of a retinanet, and is compliant with the license obtained by fizyr (apache license 2.0) according to which it can be used for any purpose other than liability, warranty andtrademark use.
Manual- https://drive.google.com/open?id=1ZB8Tj-F8wli2ou0-lY7f1PxM7hymkX8x
Code- https://drive.google.com/open?id=1XuqvVAxWtDa3pZFUNm7ZgUMZ_ncAEtB2
please find the model also in the above location as it was above 100 mb and github didnt allow it

The model also performs object detection with a bounding box along with the assigned task of object recognition. I added this feature because you are an organsation which works in displaying maps and I figured that a bounding box would be a lot more useful than a simple probability score. The model is trained after 450 epochs using google collaboratory's free GPU. It can be run by running ./examples/ResNet50RetinaNet.ipynb. Also, retinanet is a state of the art infrastructure which has achieved new sclaes of accuracy. It has achived higher accuracies then even two-staged architecture models and a higher efficiency than single-staged architecture models
