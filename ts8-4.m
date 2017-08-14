k_wrapper localstate args inputs id = outbound_messages_this_timestep : (k_wrapper localstate args future_messages id)
                                      where
                                      q = (getargval.hd) (filter ((="q").getargstr) args)
                                      k = (getargval.hd) (filter ((="k").getargstr) args)
                                      inbound_messages_this_timestep  = snd (hd inputs)
                                      t                               = fst (hd inputs)
                                      future_messages                 = tl inputs
                                      outbound_messages_this_timestep = [Message (id,2) [(Arg ("k_f1",k_f1 t))]]
                                      k_f1 0 = 0
                                      k_f1 t = k + q + j_f1_last_timestep
                                               where
                                               msgs_from_j        = filter ((=2).getmsgfrom) inbound_messages_this_timestep
                                               args_from_j        = concat (map getmsgargs msgs_from_j)
                                               j_f1_last_timestep = (getargval.hd) (filter ((="j_f1").getargstr) args_from_j)
jf1_delay localstate args inputs id = outbound_messages_this_timestep : (jf1_delay localstate args future_messages id)
                                      where
                                      inbound_messages_this_timestep  = snd (hd inputs)
                                      future_messages                 = tl inputs
                                      t                               = fst (hd inputs)
                                      outbound_messages_this_timestep = [Message (id, 4) [(Arg ("j_f1c", jf2_current t))], Message (id, 1) [(Arg ("j_f1d", jf2_delayed))]]
                                      msgs_from_j        = filter ((=2).getmsgfrom) inbound_messages_this_timestep
                                      args_from_j        = concat (map getmsgargs msgs_from_j)
                                      jf2_current        = (getargval.hd) (filter ((="j_f1").getargstr) args_from_j)
                                      msgs_from_jd        = filter ((=4).getmsgfrom) inbound_messages_this_timestep
                                      args_from_jd        = concat (map getmsgargs msgs_from_jd)
                                      jf2_delayed         = (getargval.hd) (filter ((="j_f1c").getargstr) args_from_jd)
