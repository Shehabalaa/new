f1 = open("aa.txt","r")
f2 = open("goodaa.txt","w")

for line in f1:
	if (line.find("mov") or line.find("cmp")):
		arr1=line.split(',')
		var = arr1[1]
		#print var +'\n'		
		if('0' <= var[0] <= '9'):
			#print var[-2] +'\n'		
			if( not('0' <= var[-2] <= '9') and  var[-2]=='d'):
				number = int(var[0:-3],16)
				number = str(number)
				number+='h'
				number.replace(" ","")
				while(len(number)<5):
					number ='0'+number
				print number
			elif(not('0' <= var[-2] <= '9')and var[-2]=='h'):
				number = int(var[0:-3].replace(" ", ""),16)
				number = str(number)
				number+='h'
				number.replace(" ","")
				while(len(number)<5):
					number ='0'+number
				print number	
			elif(not('0' <= var[-2] <= '9') and var[-2]=='b'):
				number = int(var[0:-3].replace(" ", ""),16)
				number = str(number)
				number+='h'
				number.replace(" ","")
				while(len(number)<5):
					number ='0'+number
				print number		
			else:
				number = int(var[0:-2].replace(" ", ""),16)
				number = str(number)
				number+='h'
				number.replace(" ","")
				while(len(number)<5):
					number ='0'+number
				print number
			

f1.close()
f2.close()
