# pip install opencv-python
from flask import Flask , request, render_template , make_response ,jsonify ## flask 라이브러리에서 Flask import
import numpy as np
import cv2
import base64
app = Flask(__name__)
@app.route('/test_img', methods=['POST'])
def rest_img_test():
     if request.method == 'POST':
         param = request.form.get('data')
         print(param)
         f = request.files['file']
         filestr = f.read()
         npimg = np.fromstring(filestr, np.uint8) # FileStorage의 이미지를 넘파이 배열로 만듬
         img = cv2.imdecode(npimg, cv2.IMREAD_COLOR) # 넘파일 배열을 이미지 배열로 변환함
         img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) # 여기에서 처리를 하면 됨
         cv2.imwrite(f.filename, img)
         img_str = base64.b64encode(cv2.imencode('.jpg', img)[1]).decode()
         data = {"param": param, "file": img_str}
         response = make_response(jsonify(data))
         response.headers.add("Access-Control-Allow-Origin", "*")
     return response
if __name__ == "__main__":
 app.run()