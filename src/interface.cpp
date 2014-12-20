///////////////////////////////////////////////////////////////////////////
// Copyright (C) 2014 Jason E. Aten                                      //
//   derived from rzmq code that is copyright (C) 2011 Whit Armstrong    //   
//   and available under the GPL-3 as well.                              //
//                                                                       //
// This program is free software: you can redistribute it and/or modify  //
// it under the terms of the GNU General Public License as published by  //
// the Free Software Foundation, either version 3 of the License, or     //
// (at your option) any later version.                                   //
//                                                                       //
// This program is distributed in the hope that it will be useful,       //
// but WITHOUT ANY WARRANTY; without even the implied warranty of        //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         //
// GNU General Public License for more details.                          //
//                                                                       //
// You should have received a copy of the GNU General Public License     //
// along with this program.  If not, see <http://www.gnu.org/licenses/>. //
///////////////////////////////////////////////////////////////////////////

#include <stdint.h>
#include <string>
#include <sstream>
#include <stdexcept>
#include <string.h>
#include <stdlib.h>
#include "nanomsg/nn.h"
#include "nanomsg/pair.h"
#include "nanomsg/pubsub.h"
#include "nanomsg/bus.h"
#include "nanomsg/inproc.h"
#include "nanomsg/ipc.h"
#include "nanomsg/nn.h"
#include "nanomsg/pair.h"
#include "nanomsg/pipeline.h"
#include "nanomsg/pubsub.h"
#include "nanomsg/reqrep.h"
#include "nanomsg/survey.h"
#include "nanomsg/tcp.h"
#include "nanomsg/transport.h"


#include "interface.h"

SEXP nnVersion() {
  SEXP ans;
  int major, minor, patch;
  std::stringstream out;
  out << NN_VERSION_CURRENT << "." << NN_VERSION_REVISION;
  PROTECT(ans = allocVector(STRSXP,1));
  SET_STRING_ELT(ans, 0, mkChar(out.str().c_str()));
  UNPROTECT(1);
  return ans;
}

SEXP nnErrno() {
  SEXP ans; PROTECT(ans = allocVector(INTSXP,1));
  INTEGER(ans)[0] = nn_errno();
  UNPROTECT(1);
  return ans;
}

SEXP nnClearErrno() {
  errno = 0;
  return R_NilValue;
}


SEXP nnStrerror() {
  SEXP ans; PROTECT(ans = allocVector(STRSXP,1));
  SET_STRING_ELT(ans, 0, mkChar(nn_strerror(nn_errno())));
  UNPROTECT(1);
  return ans;
}

int string_to_socket_type(const std::string s) {
  if (s == "NN_PAIR") { return NN_PAIR; }
  if (s == "NN_PUB") { return NN_PUB; }
  if (s == "NN_SUB") { return NN_SUB; }
  if (s == "NN_REP") { return NN_REP; }
  if (s == "NN_REQ") { return NN_REQ; }
  if (s == "NN_PUSH") { return NN_PUSH; }
  if (s == "NN_PULL") { return NN_PULL; }
  if (s == "NN_SURVEYOR") { return NN_SURVEYOR; }
  if (s == "NN_RESPONDENT") { return NN_RESPONDENT; }
  if (s == "NN_BUS") { return NN_BUS; }
  return -1;
}

int symbol_string_to_int(const std::string s) {
  if (s == "NN_NS_NAMESPACE") { return NN_NS_NAMESPACE; }
  if (s == "NN_NS_VERSION") { return NN_NS_VERSION; }
  if (s == "NN_NS_DOMAIN") { return NN_NS_DOMAIN; }
  if (s == "NN_NS_TRANSPORT") { return NN_NS_TRANSPORT; }
  if (s == "NN_NS_PROTOCOL") { return NN_NS_PROTOCOL; }
  if (s == "NN_NS_OPTION_LEVEL") { return NN_NS_OPTION_LEVEL; }
  if (s == "NN_NS_SOCKET_OPTION") { return NN_NS_SOCKET_OPTION; }
  if (s == "NN_NS_TRANSPORT_OPTION") { return NN_NS_TRANSPORT_OPTION; }
  if (s == "NN_NS_OPTION_TYPE") { return NN_NS_OPTION_TYPE; }
  if (s == "NN_NS_FLAG") { return NN_NS_FLAG; }
  if (s == "NN_NS_ERROR") { return NN_NS_ERROR; }
  if (s == "NN_NS_LIMIT") { return NN_NS_LIMIT; }
  if (s == "NN_TYPE_NONE") { return NN_TYPE_NONE; }
  if (s == "NN_TYPE_INT") { return NN_TYPE_INT; }
  if (s == "NN_TYPE_STR") { return NN_TYPE_STR; }
  if (s == "NN_UNIT_NONE") { return NN_UNIT_NONE; }
  if (s == "NN_UNIT_BYTES") { return NN_UNIT_BYTES; }
  if (s == "NN_UNIT_MILLISECONDS") { return NN_UNIT_MILLISECONDS; }
  if (s == "NN_UNIT_PRIORITY") { return NN_UNIT_PRIORITY; }
  if (s == "NN_UNIT_BOOLEAN") { return NN_UNIT_BOOLEAN; }
  if (s == "NN_VERSION_CURRENT") { return NN_VERSION_CURRENT; }
  if (s == "NN_VERSION_REVISION") { return NN_VERSION_REVISION; }
  if (s == "NN_VERSION_AGE") { return NN_VERSION_AGE; }
  if (s == "AF_SP") { return AF_SP; }
  if (s == "AF_SP_RAW") { return AF_SP_RAW; }
  if (s == "NN_INPROC") { return NN_INPROC; }
  if (s == "NN_IPC") { return NN_IPC; }
  if (s == "NN_TCP") { return NN_TCP; }
  if (s == "NN_PAIR") { return NN_PAIR; }
  if (s == "NN_PUB") { return NN_PUB; }
  if (s == "NN_SUB") { return NN_SUB; }
  if (s == "NN_REP") { return NN_REP; }
  if (s == "NN_REQ") { return NN_REQ; }
  if (s == "NN_PUSH") { return NN_PUSH; }
  if (s == "NN_PULL") { return NN_PULL; }
  if (s == "NN_SURVEYOR") { return NN_SURVEYOR; }
  if (s == "NN_RESPONDENT") { return NN_RESPONDENT; }
  if (s == "NN_BUS") { return NN_BUS; }
  if (s == "NN_SOCKADDR_MAX") { return NN_SOCKADDR_MAX; }
  if (s == "NN_SOL_SOCKET") { return NN_SOL_SOCKET; }
  if (s == "NN_LINGER") { return NN_LINGER; }
  if (s == "NN_SNDBUF") { return NN_SNDBUF; }
  if (s == "NN_RCVBUF") { return NN_RCVBUF; }
  if (s == "NN_SNDTIMEO") { return NN_SNDTIMEO; }
  if (s == "NN_RCVTIMEO") { return NN_RCVTIMEO; }
  if (s == "NN_RECONNECT_IVL") { return NN_RECONNECT_IVL; }
  if (s == "NN_RECONNECT_IVL_MAX") { return NN_RECONNECT_IVL_MAX; }
  if (s == "NN_SNDPRIO") { return NN_SNDPRIO; }
  if (s == "NN_SNDFD") { return NN_SNDFD; }
  if (s == "NN_RCVFD") { return NN_RCVFD; }
  if (s == "NN_DOMAIN") { return NN_DOMAIN; }
  if (s == "NN_PROTOCOL") { return NN_PROTOCOL; }
  if (s == "NN_IPV4ONLY") { return NN_IPV4ONLY; }
  if (s == "NN_SOCKET_NAME") { return NN_SOCKET_NAME; }
  if (s == "NN_SUB_SUBSCRIBE") { return NN_SUB_SUBSCRIBE; }
  if (s == "NN_SUB_UNSUBSCRIBE") { return NN_SUB_UNSUBSCRIBE; }
  if (s == "NN_REQ_RESEND_IVL") { return NN_REQ_RESEND_IVL; }
  if (s == "NN_SURVEYOR_DEADLINE") { return NN_SURVEYOR_DEADLINE; }
  if (s == "NN_TCP_NODELAY") { return NN_TCP_NODELAY; }
  if (s == "NN_DONTWAIT") { return NN_DONTWAIT; }
  if (s == "EADDRINUSE") { return EADDRINUSE; }
  if (s == "EADDRNOTAVAIL") { return EADDRNOTAVAIL; }
  if (s == "EAFNOSUPPORT") { return EAFNOSUPPORT; }
  if (s == "EAGAIN") { return EAGAIN; }
  if (s == "EBADF") { return EBADF; }
  if (s == "ECONNREFUSED") { return ECONNREFUSED; }
  if (s == "EFAULT") { return EFAULT; }
  if (s == "EFSM") { return EFSM; }
  if (s == "EINPROGRESS") { return EINPROGRESS; }
  if (s == "EINTR") { return EINTR; }
  if (s == "EINVAL") { return EINVAL; }
  if (s == "EMFILE") { return EMFILE; }
  if (s == "ENAMETOOLONG") { return ENAMETOOLONG; }
  if (s == "ENETDOWN") { return ENETDOWN; }
  if (s == "ENOBUFS") { return ENOBUFS; }
  if (s == "ENODEV") { return ENODEV; }
  if (s == "ENOMEM") { return ENOMEM; }
  if (s == "ENOPROTOOPT") { return ENOPROTOOPT; }
  if (s == "ENOTSOCK") { return ENOTSOCK; }
  if (s == "ENOTSUP") { return ENOTSUP; }
  if (s == "EPROTO") { return EPROTO; }
  if (s == "EPROTONOSUPPORT") { return EPROTONOSUPPORT; }
  if (s == "ETERM") { return ETERM; }
  if (s == "ETIMEDOUT") { return ETIMEDOUT; }
  if (s == "EACCES" ) { return EACCES; }
  if (s == "ECONNABORTED") { return ECONNABORTED; }
  if (s == "ECONNRESET") { return ECONNRESET; }
  if (s == "EHOSTUNREACH") { return EHOSTUNREACH; }
  if (s == "EMSGSIZE") { return EMSGSIZE; }
  if (s == "ENETRESET") { return ENETRESET; }
  if (s == "ENETUNREACH") { return ENETUNREACH; }
  if (s == "ENOTCONN") { return ENOTCONN; }
  return -1000;
}

SEXP nn(SEXP str_) {
  SEXP ans; 

  if(TYPEOF(str_) != STRSXP) {
    REprintf("argument to nn() must be a string to be decoded to its integer constant value in the nanomsg pkg.\n");
    return R_NilValue;
  }

  PROTECT(ans = allocVector(INTSXP,1));
  const char* s = CHAR(STRING_ELT(str_,0));
  int rc = symbol_string_to_int(s);
  INTEGER(ans)[0] = rc;
  UNPROTECT(1);
  if (rc == -1000) {
    REprintf("error: could not translate string '%s' to nanomsg constant.\n", s);
    return R_NilValue;
  }
  return ans;
}


int string_to_domain_type(const std::string s) {
  if (s == "AF_SP") { return AF_SP; }
  if (s == "AF_SP_RAW") { return AF_SP_RAW; }
  return -1;
}
  
int check_and_get_socket(SEXP socket_) {
  int sock;
  if(TYPEOF(socket_) != INTSXP && TYPEOF(socket_) != REALSXP) {
      error("socket must be an number previously returned from nn.socket().");
  }
  if (TYPEOF(socket_) == REALSXP) {
    sock = int(REAL(socket_)[0]);
  } else {
    sock = INTEGER(socket_)[0];
  }
  if (sock < 0) {
     error("socket must be an non-negative integer.");
  }
  return sock;
}

SEXP nnClose(SEXP socket_) {
  int sock = check_and_get_socket(socket_);

  SEXP ans; PROTECT(ans = allocVector(INTSXP,1));
  int rc = nn_close(sock);
  INTEGER(ans)[0] = rc;
  UNPROTECT(1);
  if (rc < 0) {
     
  }
  return ans;
}

SEXP nnTerm() {
  nn_term();
  return R_NilValue;
}


SEXP nnSocket(SEXP domain_, SEXP protocol_) {
  SEXP socket_;
  SEXP ans;

  int domain_type = -1;
  if (TYPEOF(domain_) != INTSXP) {
    REprintf("domain (1st arg) has unrecongized type. Acceptable: nn.AF_SP and nn.AF_SP_RAW are available.\n");
    return R_NilValue;
  }
  domain_type = int(INTEGER(domain_)[0]);

  if(domain_type < 0) {
    REprintf("bad domain value (1st arg). Acceptable: nn.AF_SP and nn.AF_SP_RAW are available.\n");
    return R_NilValue;
  }

  int socket_type = -1;
  if (TYPEOF(protocol_) != INTSXP) {
    REprintf("socket type (protocol; 1st arg) has unrecongized type.\n");
    return R_NilValue;
  }
  socket_type = INTEGER(protocol_)[0];

  if(socket_type < 0) {
    REprintf("socket type (2nd arg, a.k.a. protocol) not recgonized. Available socket types: {nn.PAIR, nn.PUB, nn.SUB, nn.REP, nn.REQ, nn.PUSH, nn.PULL, nn.SURVEYOR, nn.RESPONDENT, nn.BUS}.\n");
    return R_NilValue;
  }

  PROTECT(ans = allocVector(INTSXP,1));
  INTEGER(ans)[0] = nn_socket(domain_type, socket_type);
  UNPROTECT(1);
  return ans;
}

SEXP nnBind(SEXP socket_, SEXP address_) {
  SEXP ans; 
  int sock = check_and_get_socket(socket_);

  if(TYPEOF(address_) != STRSXP) {
    REprintf("address type must be a string.\n");
    return R_NilValue;
  }

  PROTECT(ans = allocVector(INTSXP,1)); 
  INTEGER(ans)[0] = nn_bind(INTEGER(socket_)[0], CHAR(STRING_ELT(address_,0)));
  UNPROTECT(1);
  return ans;
}


SEXP nnListenAndServe(SEXP socket_, SEXP handler_, SEXP environ_) {
  int sock = check_and_get_socket(socket_);
  int msglen = 0;
  void* buf = 0;
  SEXP evalres;

  SEXP R_fcall, msg;
  if(!isFunction(handler_)) error("‘handler’ must be a function");
  if(!isEnvironment(environ_)) error("‘environ’ should be an environment");

  while(1) {
    // blocking read
    REprintf("nnListenAndServe: just prior to blocking waiting for msg\n");
    msglen = nn_recv(INTEGER(socket_)[0], &buf, NN_MSG, 0);
    if (msglen < 0) {
        error("error in nnRecv(): '%s'.\n", nn_strerror(nn_errno()));
        return R_NilValue;
    }
    
    PROTECT(msg = allocVector(RAWSXP,msglen));
    memcpy(RAW(msg),buf,msglen);
    if (nn_freemsg(buf) < 0) {
      error("bad buf: message pointer is invalid, in nnListenAndServer() loop.\n");    
    }

    // put msg into env that handler_ is called with.
    defineVar(install("msg"), msg, environ_);

    // evaluate
    REprintf("nnListenAndServe: got msg, just prior to eval.\n");
    PROTECT(evalres = eval(handler_, environ_));
    REprintf("nnListenAndServe: evalres = %p.\n",evalres);
    REprintf("nnListenAndServe: done with eval.\n");
    UNPROTECT(2);

    // temp: to debug: return our value back from res
    return evalres;
  }
  
  return R_NilValue;
}

/*
static short rzmq_build_event_bitmask(SEXP askevents) {
    short bitmask = 0;
    if(TYPEOF(askevents) == STRSXP) {
        for (int i = 0; i < LENGTH(askevents); i++) {
            const char *ask = translateChar(STRING_ELT(askevents, i));
            if (strcmp(ask, "read") == 0) {
                bitmask |= ZMQ_POLLIN;
            } else if (strcmp(ask, "write") == 0) {
                bitmask |= ZMQ_POLLOUT;
            } else if (strcmp(ask, "error") == 0) {
                bitmask |= ZMQ_POLLERR;
            } else {
                error("unrecognized requests poll event %s.", ask);
            }
        }
    } else {
        error("event list passed to poll must be a string or vector of strings");
    }
    return bitmask;
}

SEXP pollSocket(SEXP sockets_, SEXP events_, SEXP timeout_) {
    SEXP result;
    
    if(TYPEOF(timeout_) != INTSXP) {
        error("poll timeout must be an integer.");
    }

    if(TYPEOF(sockets_) != VECSXP || LENGTH(sockets_) == 0) {
        error("A non-empy list of sockets is required as first argument.");
    }

    int nsock = LENGTH(sockets_);
    PROTECT(result = allocVector(VECSXP, nsock));

    if (TYPEOF(events_) != VECSXP) {
        error("event list must be a list of strings or a list of vectors of strings.");
    }
    if(LENGTH(events_) != nsock) {
        error("event list must be the same length as socket list.");
    }

    zmq_pollitem_t *pitems = (zmq_pollitem_t*)R_alloc(nsock, sizeof(zmq_pollitem_t));
    if (pitems == NULL) {
        error("failed to allocate memory for zmq_pollitem_t array.");
    }

    try {
        for (int i = 0; i < nsock; i++) {
            zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(VECTOR_ELT(sockets_, i), "zmq::socket_t*"));
            pitems[i].socket = (void*)*socket;
            pitems[i].events = rzmq_build_event_bitmask(VECTOR_ELT(events_, i));
        }

        int rc = zmq::poll(pitems, nsock, *INTEGER(timeout_));

        if(rc >= 0) {
            for (int i = 0; i < nsock; i++) {
                SEXP events, names;

                // Pre count number of polled events so we can
                // allocate appropriately sized lists.
                short eventcount = 0;
                if (pitems[i].events & ZMQ_POLLIN) eventcount++;
                if (pitems[i].events & ZMQ_POLLOUT) eventcount++;
                if (pitems[i].events & ZMQ_POLLERR) eventcount++;

                PROTECT(events = allocVector(VECSXP, eventcount));
                PROTECT(names = allocVector(VECSXP, eventcount));

                eventcount = 0;
                if (pitems[i].events & ZMQ_POLLIN) {
                    SET_VECTOR_ELT(events, eventcount, ScalarLogical(pitems[i].revents & ZMQ_POLLIN));
                    SET_VECTOR_ELT(names, eventcount, mkChar("read"));
                    eventcount++;
                }

                if (pitems[i].events & ZMQ_POLLOUT) {
                    SET_VECTOR_ELT(names, eventcount, mkChar("write"));

                    SET_VECTOR_ELT(events, eventcount, ScalarLogical(pitems[i].revents & ZMQ_POLLOUT));
                    eventcount++;
                }

                if (pitems[i].events & ZMQ_POLLERR) {
                    SET_VECTOR_ELT(names, eventcount, mkChar("error"));
                    SET_VECTOR_ELT(events, eventcount, ScalarLogical(pitems[i].revents & ZMQ_POLLERR));
                }
                setAttrib(events, R_NamesSymbol, names);
                SET_VECTOR_ELT(result, i, events);
            }
        } else {
            error("polling zmq sockets failed.");
        }
    } catch(std::exception& e) {
        error(e.what());
    }
    // Release the result list (1), and per socket
    // events lists with associated names (2*nsock).
    UNPROTECT(1 + 2*nsock);
    return result;
}
*/

SEXP nnConnect(SEXP socket_, SEXP address_) {
  SEXP ans; 

  if(TYPEOF(socket_) != INTSXP) {
    REprintf("socket must be an integer: a file descriptor previously generated by nnSocket().\n");
    return R_NilValue;
  }
  int sock = check_and_get_socket(socket_);

  if(TYPEOF(address_) != STRSXP) {
    REprintf("address type must be a string.\n");
    return R_NilValue;
  }

  PROTECT(ans = allocVector(INTSXP,1)); 
  INTEGER(ans)[0] = nn_connect(INTEGER(socket_)[0], CHAR(STRING_ELT(address_,0)));
  UNPROTECT(1);
  return ans;
}

SEXP nnShutdown(SEXP socket_, SEXP how_) {
  SEXP ans; 
  int sock = check_and_get_socket(socket_);

  if(TYPEOF(how_) != INTSXP) {
    REprintf("bad 2nd arg to nnShutdown(s, how): 'how' must be a integer.\n");
    return R_NilValue;
  }

  PROTECT(ans = allocVector(INTSXP,1)); 
  INTEGER(ans)[0] = nn_shutdown(INTEGER(socket_)[0], INTEGER(how_)[0]);
  UNPROTECT(1);
  return ans;
}

SEXP nnSetSockOpt(SEXP socket_, SEXP level_, SEXP option_, SEXP optval_) {
  SEXP ans; 
  int level, option;
  int optval_int;
  void* optval = &optval_int;
  size_t optvallen;
  optvallen = sizeof(int);

  int sock = check_and_get_socket(socket_);

  // level
  if(TYPEOF(level_) == INTSXP) {
    level = INTEGER(level_)[0];

  } else if (TYPEOF(level_) == STRSXP) {
    level = symbol_string_to_int(CHAR(STRING_ELT(level_,0)));
    if (level < 0) {
      REprintf("unrecognized 'level' value in nnSetSockOpt().\n");
      return R_NilValue;
    }
  } else {
    REprintf("level must be either (a) an integer; or (b) a string corresponding to a level name.\n");
    return R_NilValue;
  }

  // option
  if(TYPEOF(option_) == INTSXP) {
    option = INTEGER(option_)[0];

  } else if (TYPEOF(option_) == STRSXP) {
    option = symbol_string_to_int(CHAR(STRING_ELT(option_,0)));
    if (option < 0) {
      REprintf("unrecognized 'option' value in nnSetSockOpt().\n");
      return R_NilValue;
    }
  } else {
    REprintf("option must be either (a) an integer; or (b) a string corresponding to a option name.\n");
    return R_NilValue;
  }

  // optval
  if(TYPEOF(optval_) == INTSXP) {
    optval_int = INTEGER(optval_)[0];
  } else if (TYPEOF(optval_) == STRSXP) {
    optval = (void*)CHAR(STRING_ELT(optval_,0));
    optvallen = strnlen((char*)optval, 4096);
  } else {
    REprintf("optval must be either an integer or a string.\n");
    return R_NilValue;
  }

  PROTECT(ans = allocVector(INTSXP,1)); 
  INTEGER(ans)[0] = nn_setsockopt(INTEGER(socket_)[0], level, option, optval, optvallen);
  UNPROTECT(1);

  return ans;
}


SEXP nnGetSockOpt(SEXP socket_, SEXP level_, SEXP option_) {
  SEXP ans; 
  int level, option;
  int optval;
  size_t optvallen;
  int rc;

  optval = 0;
  optvallen = sizeof(int);

  int sock = check_and_get_socket(socket_);

  // level
  if(TYPEOF(level_) == INTSXP) {
    level = INTEGER(level_)[0];

  } else if (TYPEOF(level_) == STRSXP) {
    level = symbol_string_to_int(CHAR(STRING_ELT(level_,0)));
    if (level < 0) {
      REprintf("unrecognized 'level' value in nnGetSockOpt().\n");
      return R_NilValue;
    }
  } else {
    REprintf("level must be either (a) an integer; or (b) a string corresponding to a level name.\n");
    return R_NilValue;
  }

  // option
  if(TYPEOF(option_) == INTSXP) {
    option = INTEGER(option_)[0];

  } else if (TYPEOF(option_) == STRSXP) {
    option = symbol_string_to_int(CHAR(STRING_ELT(option_,0)));
    if (option < 0) {
      REprintf("unrecognized 'option' value in nnGetSockOpt().\n");
      return R_NilValue;
    }
  } else {
    REprintf("option must be either (a) an integer; or (b) a string corresponding to a option name.\n");
    return R_NilValue;
  }
  if (option == NN_SOCKET_NAME || option == NN_DOMAIN || option == NN_PROTOCOL) {
    REprintf("only integer option getting is supported in nanomsgardvark in nnGetSockOpt().\n");
    return R_NilValue;
  }

  rc = nn_getsockopt(INTEGER(socket_)[0], level, option, &optval, &optvallen);
  if (rc == -1) {
    //error("error in nnGetSockOpt(): '%s'.\n", nn_strerror(nn_errno()));
    //return R_NilValue;
    optval = rc;
  }
  PROTECT(ans = allocVector(INTSXP,1)); 
  INTEGER(ans)[0] = optval;
  UNPROTECT(1);
  return ans;
}


SEXP nnSend(SEXP socket_, SEXP data_, SEXP dont_wait_) {
  SEXP ans; 

  int sock = check_and_get_socket(socket_);

  if(TYPEOF(dont_wait_) != LGLSXP) {
    REprintf("dont_wait type must be logical (LGLSXP).\n");
    return R_NilValue;
  }
  int flags = LOGICAL(dont_wait_)[0];

  if(TYPEOF(data_) != RAWSXP) {
    REprintf("data type must be raw (RAWSXP).\n");
    return R_NilValue;
  }

  PROTECT(ans = allocVector(INTSXP,1));
  int rc = nn_send(INTEGER(socket_)[0], RAW(data_), length(data_), flags);
  if(rc < 0) {
    if (flags && nn_errno() == EAGAIN) {
      // ok fine, just try again later.
    } else {
      error("error in nnSend(): '%s'.\n", nn_strerror(nn_errno()));
      UNPROTECT(1);
      return R_NilValue;
    }
  }

  INTEGER(ans)[0] = rc;
  UNPROTECT(1);
  return ans;
}

SEXP nnRecv(SEXP socket_, SEXP dont_wait_) {
  SEXP ans;

  int sock = check_and_get_socket(socket_);

  if(TYPEOF(dont_wait_) != LGLSXP) {
    REprintf("dont_wait type must be logical (LGLSXP).\n");
    return R_NilValue;
  }
  int dont_wait = LOGICAL(dont_wait_)[0];

  void* buf;
  int msglen = nn_recv(INTEGER(socket_)[0], &buf, NN_MSG, dont_wait);
  if (msglen < 0) {
    if (dont_wait && nn_errno() == EAGAIN) {
      // ok fine, just try again later

      // gotta return an error value, INTSXP lets
      // us know on the R side that we got an error
      PROTECT(ans = allocVector(INTSXP,1));
      INTEGER(ans)[0] = msglen;
      UNPROTECT(1);
      return ans;

    } else {
      error("error in nnRecv(): '%s'.\n", nn_strerror(nn_errno()));
      return R_NilValue;
    }
  }

  PROTECT(ans = allocVector(RAWSXP,msglen));
  memcpy(RAW(ans),buf,msglen);
  UNPROTECT(1);
  if (nn_freemsg(buf) < 0) {
    error("bad buf: message pointer is invalid, in nnRecv().\n");    
  }
  return ans;
}


/*
SEXP sendRawString(SEXP socket_, SEXP data_, SEXP send_more_) {
  SEXP ans;
  bool status(false);
  if(TYPEOF(data_) != STRSXP) {
    REprintf("data type must be raw (STRSXP).\n");
    return R_NilValue;
  }

  if(TYPEOF(send_more_) != LGLSXP) {
    REprintf("send.more type must be logical (LGLSXP).\n");
    return R_NilValue;
  }

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) {
    REprintf("bad socket object.\n");
    return R_NilValue;
  }

  const char* data = CHAR(STRING_ELT(data_,0));
  zmq::message_t msg (strlen(data));
  memcpy(msg.data(), data, strlen(data));

  bool send_more = LOGICAL(send_more_)[0];
  try {
    if(send_more) {
      status = socket->send(msg,ZMQ_SNDMORE);
    } else {
      status = socket->send(msg);
    }
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
  }
  PROTECT(ans = allocVector(LGLSXP,1));
  LOGICAL(ans)[0] = static_cast<int>(status);
  UNPROTECT(1);
  return ans;
}


SEXP receiveString(SEXP socket_) {
  SEXP ans;
  bool status(false);
  zmq::message_t msg;
  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  try {
    status = socket->recv(&msg);
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
  }
  if(status) {
    PROTECT(ans = allocVector(STRSXP,1));
    char* string_msg = new char[msg.size() + 1];
    if(string_msg == NULL) {
      UNPROTECT(1);
      return R_NilValue;
    }
    memcpy(string_msg,msg.data(),msg.size());
    string_msg[msg.size()] = 0;
    SET_STRING_ELT(ans, 0, mkChar(string_msg));
    UNPROTECT(1);
    return ans;
  }
  return R_NilValue;
}

SEXP receiveInt(SEXP socket_) {
  SEXP ans;
  bool status(false);
  zmq::message_t msg;
  try {
    zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
    status = socket->recv(&msg);
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
  }
  if(status) {
    if(msg.size() != sizeof(int)) {
      REprintf("bad integer size on remote machine.\n");
      return R_NilValue;
    }
    PROTECT(ans = allocVector(INTSXP,1));
    memcpy(INTEGER(ans),msg.data(),msg.size());
    UNPROTECT(1);
    return ans;
  }
  return R_NilValue;
}

SEXP receiveDouble(SEXP socket_) {
  SEXP ans;
  bool status(false);
  zmq::message_t msg;
  try {
    zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
    status = socket->recv(&msg);
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
  }
  if(status) {
    if(msg.size() != sizeof(double)) {
      REprintf("bad double size on remote machine.\n");
      return R_NilValue;
    }
    PROTECT(ans = allocVector(REALSXP,1));
    memcpy(REAL(ans),msg.data(),msg.size());
    UNPROTECT(1);
    return ans;
  }
  return R_NilValue;
}

#if ZMQ_VERSION_MAJOR < 3
// removed from libzmq3
SEXP set_hwm(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  uint64_t option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_HWM, &option_value, sizeof(uint64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

#endif

#if ZMQ_VERSION_MAJOR < 3
// removed from libzmq3
SEXP set_swap(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  int64_t option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_SWAP, &option_value, sizeof(int64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}
#endif

SEXP set_affinity(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  uint64_t option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_AFFINITY, &option_value, sizeof(uint64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_identity(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=STRSXP) { REprintf("option value must be a string.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;
  const char* option_value = CHAR(STRING_ELT(option_value_,0));
  try {
    socket->setsockopt(ZMQ_IDENTITY, option_value,strlen(option_value));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP subscribe(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=STRSXP) { REprintf("option value must be a string.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;
  const char* option_value = CHAR(STRING_ELT(option_value_,0));
  try {
    socket->setsockopt(ZMQ_SUBSCRIBE, option_value,strlen(option_value));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP unsubscribe(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=STRSXP) { REprintf("option value must be a string.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;
  const char* option_value = CHAR(STRING_ELT(option_value_,0));
  try {
    socket->setsockopt(ZMQ_UNSUBSCRIBE, option_value,strlen(option_value));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_rate(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;
#if ZMQ_VERSION_MAJOR > 2
  int option_value;
#else
  int64_t option_value;
#endif

  option_value = INTEGER(option_value_)[0];
  try {
    socket->setsockopt(ZMQ_RATE, &option_value, sizeof(int64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_recovery_ivl(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;
#if ZMQ_VERSION_MAJOR > 2
  int option_value;
#else
  int64_t option_value;
#endif
  option_value = INTEGER(option_value_)[0];
  try {
    socket->setsockopt(ZMQ_RECOVERY_IVL, &option_value, sizeof(int64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}


#if ZMQ_VERSION_MAJOR < 3
// removed from libzmq3
SEXP set_recovery_ivl_msec(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  int64_t option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_RECOVERY_IVL_MSEC, &option_value, sizeof(int64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}
#endif

#if ZMQ_VERSION_MAJOR < 3
// removed from libzmq3
SEXP set_mcast_loop(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=LGLSXP) { REprintf("option value must be a logical.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  int64_t option_value(LOGICAL(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_MCAST_LOOP, &option_value, sizeof(int64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}
#endif

SEXP set_sndbuf(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

#if ZMQ_VERSION_MAJOR > 2
  int option_value;
#else
  int64_t option_value;
#endif

  option_value = INTEGER(option_value_)[0];
  try {
    socket->setsockopt(ZMQ_SNDBUF, &option_value, sizeof(uint64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_rcvbuf(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

#if ZMQ_VERSION_MAJOR > 2
  int option_value;
#else
  int64_t option_value;
#endif

  option_value = INTEGER(option_value_)[0];
  try {
    socket->setsockopt(ZMQ_RCVBUF, &option_value, sizeof(uint64_t));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_linger(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  int option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_LINGER, &option_value, sizeof(int));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_reconnect_ivl(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  int option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_RECONNECT_IVL, &option_value, sizeof(int));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_zmq_backlog(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  int option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_BACKLOG, &option_value, sizeof(int));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_reconnect_ivl_max(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  int option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_RECONNECT_IVL_MAX, &option_value, sizeof(int));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP set_sndtimeo(SEXP socket_, SEXP option_value_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
  if(TYPEOF(option_value_)!=INTSXP) { REprintf("option value must be an int.\n");return R_NilValue; }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1)); LOGICAL(ans)[0] = 1;

  int option_value(INTEGER(option_value_)[0]);
  try {
    socket->setsockopt(ZMQ_SNDTIMEO, &option_value, sizeof(int));
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    LOGICAL(ans)[0] = 0;
  }
  UNPROTECT(1);
  return ans;
}

SEXP get_sndtimeo(SEXP socket_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
#if ZMQ_VERSION_MAJOR > 2
  int option_value;
#else
  int64_t option_value;
#endif
  size_t option_value_len = sizeof(option_value);
  try {
    socket->getsockopt(ZMQ_SNDTIMEO, &option_value, &option_value_len);
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    return R_NilValue;
  }
  SEXP ans; PROTECT(ans = allocVector(REALSXP,1));
  REAL(ans)[0] = static_cast<int>(option_value);
  UNPROTECT(1);
  return ans;
}


SEXP get_rcvmore(SEXP socket_) {

  zmq::socket_t* socket = reinterpret_cast<zmq::socket_t*>(checkExternalPointer(socket_,"zmq::socket_t*"));
  if(!socket) { REprintf("bad socket object.\n");return R_NilValue; }
#if ZMQ_VERSION_MAJOR > 2
  int option_value;
#else
  int64_t option_value;
#endif
  size_t option_value_len = sizeof(option_value);
  try {
    socket->getsockopt(ZMQ_RCVMORE, &option_value, &option_value_len);
  } catch(std::exception& e) {
    REprintf("%s\n",e.what());
    return R_NilValue;
  }
  SEXP ans; PROTECT(ans = allocVector(LGLSXP,1));
  LOGICAL(ans)[0] = static_cast<int>(option_value);
  UNPROTECT(1);
  return ans;
}

// #define ZMQ_RCVMORE 13
// #define ZMQ_FD 14
// #define ZMQ_EVENTS 15
// #define ZMQ_TYPE 16

SEXP rzmq_serialize(SEXP data, SEXP rho) {
  static SEXP R_serialize_fun  = findVar(install("serialize"), R_GlobalEnv);
  SEXP R_fcall, ans;

  if(!isEnvironment(rho)) error("'rho' should be an environment");
  PROTECT(R_fcall = lang3(R_serialize_fun, data, R_NilValue));
  PROTECT(ans = eval(R_fcall, rho));
  UNPROTECT(2);
  return ans;
}

SEXP rzmq_unserialize(SEXP data, SEXP rho) {
  static SEXP R_unserialize_fun  = findVar(install("unserialize"), R_GlobalEnv);
  SEXP R_fcall, ans;

  if(!isEnvironment(rho)) error("'rho' should be an environment");
  PROTECT(R_fcall = lang2(R_unserialize_fun, data));
  PROTECT(ans = eval(R_fcall, rho));
  UNPROTECT(2);
  return ans;
}
*/
