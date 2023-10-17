package com.spring_memberBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Reply;

public interface BoardDao {

	@Select("SELECT NVL( MAX(BNO), 0 ) FROM BOARDS")
	int selectMaxBno();

	@Select("SELECT NVL( MAX(RENUM), 0 ) FROM REPLYS")
	int selectMaxRenum();
	
	int insertBoards(Board board);

	@Select("SELECT * FROM BOARDS WHERE BNO = #{bno}")
	Board selectBoardInfo(@Param("bno") int bno);

	@Select("SELECT * FROM BOARDS WHERE BSTATE = '1' ORDER BY BDATE DESC")
	ArrayList<Board> selectBoards();

	@Insert("INSERT INTO REPLYS( RENUM, REBNO, REMID, RECOMMENT, REDATE, RESTATE ) "
		 + " VALUES( #{renum}, #{rebno}, #{remid},#{recomment}, SYSDATE , '1' ) ")
	int insertReply(Reply re);

	@Select("SELECT * FROM REPLYS WHERE REBNO = #{rebno} AND RESTATE = '1' ORDER BY REDATE")
	ArrayList<Reply> selectReplyList( @Param("rebno") int rebno);
	
	@Update("UPDATE REPLYS SET RESTATE = '0' WHERE RENUM = #{renum}")
	int deleteReply(@Param("renum") int renum);

	
	@Select("SELECT COUNT(*) FROM REPLYS WHERE REBNO = #{bno} AND RESTATE = '1'")
	int selectBoardRecount(@Param("bno") int bno);

	
	ArrayList<HashMap<String, String>> selectBoards_map();


}








