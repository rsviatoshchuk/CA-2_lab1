#include <stdio.h>
#include <unistd.h>
#include <getopt.h>
#include <map>
#include <string>

using namespace std;


int main(int argc, char **argv) {
    int res = 0;
	int index = -1;
    
    map <char, bool> call;
	
	const struct option lng[] = {
        {"help", 		0, 0, 'h'},
        {"list", 		0, 0, 'l'},
        {"version", 	0, 0, 'v'},
        {"recognize", 	0, 0, 'r'},
		{"oneline", 	0, 0, 'o'},
		{"number", 		1, 0, 'n'},
        {0, 			0, 0, 0},
    };

    while ((res = getopt_long(argc, argv, "hlvron:", lng, &index)) != -1){
		switch (res){
        case 'h': {
            if (call['h'] == false) {
                printf("Options\n"
                       "-h\t--help\tHelp\n"
                       "-l\t--list\tList\n"
					   "-v\t--version\tVersion\n"
                       "-n\t--number\tNumber value\n"
                       "-r\t--recognize\tRecognize\n"
                       "-0\t--oneline\tOne line\n"
					   "\ndesigned by OT\n\n"); 				
                call['h'] = true;
				break;
			}
			break;
        }

		case 'l': {
			if (call['l'] == false) {
				printf("Arg: List\n");
				call['l'] = true;
				break;
			}
			break;
		}

		case 'v': {
			if (call['v'] == false) {
				printf("Arg: Version\n");
				printf("v0.1.3\n@COPYLEFT ALL WRONGS RESERVED\n");
				call['v'] = true;
				break;
			}
			break;
		}

		case 'r': {
            if (call['r'] == false) {
                printf("Arg: Recognize\n"); 				
                call['r'] = true;
				break;
			}
			break;
        }

		case 'o': {
            if (call['o'] == false) {
                printf("Arg: One line\n"); 				
                call['o'] = true;
				break;
			}
			break;
        }

		case 'n': {
            if (call['n'] == false) {
                printf("Number value : %s\n", optarg); 				
                call['n'] = true;
				break;
			}
			break;
        }

		case '?': 
		default: {
			printf("Argument %c does not exist\n", res);
			printf("Enter -h for help");
			break;
			}
        }
		index = -1;
	}
}
