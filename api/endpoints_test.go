package api

import (
    "net/http"
    //"net/http/httptest"
	"testing"
)

func TestHealthEndpoint(t *testing.T) {
	request, err := http.NewRequest("GET", "https://user.apps.pcfeu.dev.dynatracelabs.com/health", nil)
	
	if err != nil {
        t.Fatal(err)
	}

	if request == nil {
		t.Fatal(err)
	}

	//response := httptest.NewRecorder()
	//MakeHTTPHandler.ServeHTTP(response, request)

	//if response.Code != 200 {
	//	t.Fatal(err)
	//}
}

func TestMakeEndpoints(t *testing.T) {
	//	eps := MakeEndpoints(TestService)
}

func TestMakeLoginEndpoint(t *testing.T) {
	//	l := MakeLoginEndpoint(TestService)
}

func TestMakeRegisterEndpoint(t *testing.T) {
	//	r := MakeRegisterEndpoint(TestService)
}
