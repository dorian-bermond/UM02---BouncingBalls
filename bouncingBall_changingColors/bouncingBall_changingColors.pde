int ballAmount = 100 ;
float[] ballPos = new float [ballAmount * 2]  ;
float[] ballDir = new float [ballAmount * 2]  ;
int[] ballSize = new int [ballAmount] ;
int[] ballColor = new int [ballAmount * 3] ;
float[] ballColorCoef = new float [ballAmount * 3] ;
int[] baseColor = new int [3] ;
float[] ballPosition = new float [2] ;
float[] ballDirection = new float [2] ;
float[] linkCoordinates = new float[8] ; //x1, y1... x4, y4
int typicalBallSize = 40 ;
int speed = 2 ;
int maxLinkDistance = int(2 * typicalBallSize) ;
int step = 0 ;
int colorIncrement = 1 ;
int colorMinValue = 125 ;

int randint(int low, int high)
{
  return int(random(low, high)) ;
}

float getDistance(float x1, float y1, float x2, float y2)
{
  return sqrt(pow(x2-x1,2) + pow(y2-y1,2)) ;
}

void setup()
{
  //size(1368, 650) ;
  fullScreen() ;
  
  baseColor[0] = 0 ;
  baseColor[1] = 255 ;
  baseColor[2] = 255 ;

  for (int i = 0 ; i < ballAmount ; i++)
  {
    ballSize[i] = typicalBallSize + randint(-int(typicalBallSize/4), int(typicalBallSize/4)) ;
    ballPosition[0] = randint(ballSize[i]/2, width - ballSize[i]/2) ;
    ballPosition[1] = randint(ballSize[i]/2, height - ballSize[i]/2) ;
    ballDirection[0] = random(-1,1) ;
    ballDirection[1] = random(-1,1) ;

    ballPos[2*i] = ballPosition[0] ;
    ballPos[2*i + 1] = ballPosition[1] ;

    ballDir[2*i] = ballDirection[0] ;
    ballDir[2*i + 1] = ballDirection[1] ;

    ballColorCoef[3*i] = random(0.5, 1) ;
    ballColorCoef[3*i+1] = random(0.5, 1) ;
    ballColorCoef[3*i+2] = random(0.5, 1) ;

    ballColor[3*i] = int(baseColor[0] * ballColorCoef[3*i]) ;
    ballColor[3*i+1] = int(baseColor[1] * ballColorCoef[3*i+1]) ;
    ballColor[3*i+2] = int(baseColor[2] * ballColorCoef[3*i+2]) ;
  }
  noStroke() ;
}

void draw() {
  //background (150, 150, 150) ; //RGB
  background(125+int(baseColor[0]/2),125+int(baseColor[1]/2),125+int(baseColor[2]/2)) ;
  for (int i = 0 ; i < ballAmount ; i++)
  {
    ballPos[2*i] += ballDir[2*i] * speed ;
    ballPos[2*i+1] += ballDir[2*i+1] * speed ;

    if (ballPos[2*i] >= width - ballSize[i]/2 || ballPos[2*i] <= ballSize[i]/2)
    {
      ballDir[2*i] = -ballDir[2*i] ;
    }

    if (ballPos[2*i+1] >= height - ballSize[i]/2 || ballPos[2*i+1] <= ballSize[i]/2)
    {
      ballDir[2*i+1] = -ballDir[2*i+1] ;
    }
    for (int k = 0 ; k < i ; k++)
    {
      float distance = getDistance(ballPos[2*k], ballPos[2*k+1], ballPos[2*i], ballPos[2*i+1]) ;
      float maxLinkSize = int(typicalBallSize /2) ;
      if (distance <= maxLinkDistance)
      {
        int sumOfSemiDiameters = (ballSize[i] + ballSize[k]) / 2 ;
        stroke((ballColor[3*k]+ballColor[3*i])/2, (ballColor[3*k+1]+ballColor[3*i+1])/2, (ballColor[3*k+2]+ballColor[3*i+2])/2) ;
        strokeWeight(maxLinkSize * (1 - ((distance - sumOfSemiDiameters) / (maxLinkDistance - sumOfSemiDiameters)))) ;
        line(ballPos[2*k], ballPos[2*k+1], ballPos[2*i], ballPos[2*i+1]) ;
        //getLinkCoordinate(i, k, maxLinkSize, distance) ;
        //quad(linkCoordinates[0], linkCoordinates[1], linkCoordinates[2], linkCoordinates[3], linkCoordinates[4], linkCoordinates[5], linkCoordinates[6], linkCoordinates[7]) ;
      }
    }
  }
  noStroke() ;
  for (int i = 0 ; i < ballAmount ; i++)
  {
    fill(ballColor[3*i], ballColor[3*i+1], ballColor[3*i+2]) ;
    circle(ballPos[2*i], ballPos[2*i+1], ballSize[i]) ;
  }
  switch(step)
  {
    case 0 :
      if (baseColor[1] > colorMinValue) 
      {
        baseColor[1] -= colorIncrement ;
      } else {
        step++ ;
      }
      break ;
    case 1 :
      if (baseColor[0] < 255) 
      {
        baseColor[0] += colorIncrement ;
      } else {
        step++ ;
      }
      break ;
    case 2 :
      if (baseColor[2] > colorMinValue) 
      {
        baseColor[2] -= colorIncrement ;
      } else {
        step++ ;
      }
      break ;
    case 3 :
      if (baseColor[1] < 255) 
      {
        baseColor[1] += colorIncrement ;
      } else {
        step++ ;
      }
      break ;
    case 4 :
      if (baseColor[0] > colorMinValue) 
      {
        baseColor[0] -= colorIncrement ;
      } else {
        step++ ;
      }
      break ;
    case 5 :
      if (baseColor[2] < 255) 
      {
        baseColor[2] += colorIncrement ;
      } else {
        step=0 ;
      }
      break ;
      
  }
  for (int i = 0 ; i < 3 * ballAmount ; i++)
  {
    ballColor[i] = 125 - int((baseColor[i%3] - colorMinValue) * ballColorCoef[i]) ;  
  }
}
