// -*- mode: C++; c-indent-level: 2; c-basic-offset: 2; tab-width: 8 -*-
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


#ifndef INTERFACE_HPP
#define INTERFACE_HPP

#include <Rinternals.h>

//static void contextFinalizer(SEXP context_);
//static void socketFinalizer(SEXP socket_);
//SEXP nnSerialize(SEXP data, SEXP rho);
//SEXP nnUnserialize(SEXP data, SEXP rho);

extern "C" {
  SEXP nn(SEXP name_);
  SEXP nnVersion();
  SEXP nnErrno();
  SEXP nnClearErrno();
  SEXP nnStrerror();
  SEXP nnSocket(SEXP domain_, SEXP protocol_);
  SEXP nnClose(SEXP socket_);
  SEXP nnTerm();
  SEXP nnBind(SEXP socket_, SEXP address_);
  SEXP nnConnect(SEXP socket_, SEXP address_);
  SEXP nnShutdown(SEXP socket_, SEXP how_);
  SEXP nnSetSockOpt(SEXP socket_, SEXP level_, SEXP option_, SEXP optval_);
  SEXP nnGetSockOpt(SEXP socket_, SEXP level_, SEXP option_);
  SEXP nnSend(SEXP socket_, SEXP data_, SEXP dont_wait_);
  SEXP nnRecv(SEXP socket_, SEXP dont_wait_);
  SEXP nnListenAndServe(SEXP socket_, SEXP handler_, SEXP environ_);
}

#endif // INTERFACE_HPP
