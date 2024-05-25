USE data_perbankan

CREATE SCHEMA `data_perbankan` ; -- Membuat Schema


/* Membuat Tabel Nasabah */
CREATE TABLE `data_perbankan`.`nasabah` (
  `id_nasabah` INT NOT NULL AUTO_INCREMENT,
  `nama_nasabah` VARCHAR(50) NOT NULL,
  `alamat_nasabah` VARCHAR(50) NOT NULL,
  `created_date` DATETIME NULL,
  `created_by` VARCHAR(50) NULL,
  `modified_date` DATETIME NULL,
  `modified_by` VARCHAR(50) NULL,
  PRIMARY KEY (`id_nasabah`));
  
  /*------------------------------------------------------------------------------------*/
  
  INSERT 	INTO 	nasabah (nama_nasabah, alamat_nasabah, created_date, created_by)
			VALUES			('Sutopo', 'Jl. Jendral Sudirman 12', NOW(), 'Admin'),
							('Maryati', 'Jl. MT.Haryono 31', NOW(), 'Admin'),
							('Suparman', 'Jl. Hasanudi 81', NOW(), 'Admin'),
							('Kartika Padmasari', 'Jl. Manggis 15', NOW(), 'Admin'),
							('Budi Eko Prayoga', 'Jl. Kantil 30', NOW(), 'Admin'),
							('Satria Eka Jaya', 'Jl. Slamet Riyadi 45', NOW(), 'Admin'),
							('Indri Hapsari', 'Jl. Sutoyo 5', NOW(), 'Admin'),
							('Sari Murti', 'Jl. Pangandaran 11', NOW(), 'Admin'),
							('Canka Lakanata', 'Jl. Tidar 86', NOW(), 'Admin'),
							('Budi Murtono', 'Jl. Merak 22', NOW(), 'Admin');
                            
SELECT * FROM nasabah;                            
						
 /*-------------------------------------------------------------------------*/
 /* Membuat Tabel Cabang Bank */
 CREATE TABLE `data_perbankan`.`cabang_bank` (
  `kode_cabang` VARCHAR(5) NOT NULL,
  `nama_cabang` VARCHAR(50) NOT NULL,
  `alamat_cabang` VARCHAR(50) NOT NULL,
  `created_date` DATETIME NULL,
  `created_by` VARCHAR(50) NULL,
  `modified_date` DATETIME NULL,
  `modified_by` VARCHAR(50) NULL,
  PRIMARY KEY (`kode_cabang`));
 
  /*-------------------------------------------------------------------------*/
  
 INSERT 	INTO 	cabang_bank (kode_cabang, nama_cabang, alamat_cabang, created_date, created_by)
			VALUES				('BRUS', 'Bank Rut Unit Surakarta','Jl. Slamet Riyadi 18', NOW(), 'Admin'),
								('BRUM', 'Bank Rut Unit Magelang','Jl. P.Tandean 63', NOW(), 'Admin'),
								('BRUB', 'Bank Rut Unit Boyolali','Jl. Ahmad Yani 45', NOW(), 'Admin'),
								('BRUK', 'Bank Rut Unit Klaten','Jl. Suparman 23', NOW(), 'Admin'),
								('BRUY', 'Bank Rut Unit Yogyakarta','Jl. Anggrek 21', NOW(), 'Admin'),
								('BRUW', 'Bank Rut Unit Wonogiri','Jl. Untung Suropati 12', NOW(), 'Admin');
 
 SELECT * FROM cabang_bank;
 
  /*-------------------------------------------------------------------------*/
  /* Membuat Tabel Rekening */
  
  CREATE TABLE `data_perbankan`.`rekening` (
  `no_rekening` VARCHAR(3) NOT NULL,
  `kode_cabang` VARCHAR(5) NOT NULL,
  `pin` VARCHAR(4) NOT NULL,
  `saldo` INT NOT NULL,
  `created_date` DATETIME NULL,
  `created_by` VARCHAR(50) NULL,
  `modified_date` DATETIME NULL,
  `modified_by` VARCHAR(50) NULL,
  PRIMARY KEY (`no_rekening`),
  INDEX `FK_cabang_bank_idx` (`kode_cabang` ASC) ,
  CONSTRAINT `FK_cabang_bank`
    FOREIGN KEY (`kode_cabang`)
    REFERENCES `data_perbankan`.`cabang_bank` (`kode_cabang`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
/*-------------------------------------------------------------------------*/

INSERT INTO rekening (no_rekening, kode_cabang, pin, saldo, created_date, created_by)
			VALUES 	('101','BRUS', '1111', 500000, NOW(), 'Admin'),
					('102','BRUS', '2222', 350000, NOW(), 'Admin'),
					('103','BRUS', '3333', 750000, NOW(), 'Admin'),
					('104','BRUM', '4444', 900000, NOW(), 'Admin'),
					('105','BRUM', '5555', 2000000, NOW(), 'Admin'),
					('106','BRUS', '6666', 3000000, NOW(), 'Admin');
	
    SELECT * FROM rekening;
    
/*-------------------------------------------------------------------------*/
/* Membuat Tabel nasabah_has_rekening */
CREATE TABLE `data_perbankan`.`nasabah_has_rekening` (
  `id_nasabah` INT NULL,
  `no_rekening` VARCHAR(3) NULL,
  `created_date` DATETIME NULL,
  `created_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `modified_by` VARCHAR(45) NULL,
  INDEX `FK_rekening_nasabah_idx` (`no_rekening` ASC) ,
  INDEX `FK_nasabah_rekening` (`id_nasabah` ASC) ,
  CONSTRAINT `FK_nasabah_rekening`
    FOREIGN KEY (`id_nasabah`)
    REFERENCES `data_perbankan`.`nasabah` (`id_nasabah`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_rekening_nasabah`
    FOREIGN KEY (`no_rekening`)
    REFERENCES `data_perbankan`.`rekening` (`no_rekening`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    /*-------------------------------------------------------------------------*/
    
    INSERT INTO nasabah_has_rekening (id_nasabah, no_rekening, created_date, created_by)
			VALUES 	(1 ,'104', NOW(), 'Admin'),
					(2 ,'103', NOW(), 'Admin'),
                    (3 ,'105', NOW(), 'Admin'),
                    (4 ,'106', NOW(), 'Admin'),
					(5 ,'101', NOW(), 'Admin'),
                    (6 ,'102', NOW(), 'Admin');
                    
    SELECT * FROM nasabah_has_rekening;
    
    /*-------------------------------------------------------------------------*/
    /* Membuat Tabel transaksi */
    
    CREATE TABLE `data_perbankan`.`transaksi` (
  `no_transaksi` INT NOT NULL AUTO_INCREMENT,
  `no_rekening` VARCHAR(3) NOT NULL,
  `id_nasabah` INT NOT NULL,
  `jenis_transaksi` VARCHAR(50) NOT NULL,
  `tanggal` DATE NOT NULL,
  `jumlah` INT NOT NULL,
  `created_date` DATETIME NULL,
  `created_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `modified_by` VARCHAR(45) NULL,
  PRIMARY KEY (`no_transaksi`),
  INDEX `FK_transaksi_nasabah_idx` (`id_nasabah` ASC) ,
  INDEX `FK_transaksi_rekening` (`no_rekening` ASC) ,
  CONSTRAINT `FK_transaksi_nasabah`
    FOREIGN KEY (`id_nasabah`)
    REFERENCES `data_perbankan`.`nasabah` (`id_nasabah`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_transaksi_rekening`
    FOREIGN KEY (`no_rekening`)
    REFERENCES `data_perbankan`.`rekening` (`no_rekening`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
/*-------------------------------------------------------------------------*/
    
    INSERT INTO transaksi (no_rekening, id_nasabah, jenis_transaksi, tanggal, jumlah, created_date, created_by)
			VALUES 	('105' , '3' , 'debit', '2009-11-10', 50000 , NOW(), 'Admin'),
					('103' , '2' , 'debit', '2009-11-10', 40000 , NOW(), 'Admin'),
                    ('101' , '5' , 'kredit', '2009-11-12', 20000 , NOW(), 'Admin'),
					('106' , '4' , 'debit', '2009-11-13', 50000 , NOW(), 'Admin'),
                    ('101' , '5' , 'kredit', '2009-11-13', 30000 , NOW(), 'Admin'),
                    ('104' , '1' , 'kredit', '2009-11-15', 200000 , NOW(), 'Admin'),
                    ('102' , '6' , 'kredit', '2009-11-15', 150000 , NOW(), 'Admin'),
                    ('102' , '6' , 'debit', '2009-11-16', 20000 , NOW(), 'Admin'),
                    ('105' , '3' , 'kredit', '2009-11-18', 50000 , NOW(), 'Admin'),
                    ('106' , '4' , 'debit', '2009-11-19', 100000 , NOW(), 'Admin'),
                    ('103' , '2' , 'debit', '2009-11-19', 100000 , NOW(), 'Admin'),
                    ('104' , '1' , 'debit', '2009-11-19', 50000 , NOW(), 'Admin');
    
    SELECT * FROM transaksi;
    
    /*-------------------------------------------------------------------------*/

                            
/* SOAL 2 */
/* SOAL 2 a.  Nasabah dengan nama Indri Hapsari pindah alamat ke Jl. Slamet Riyadi No.34.*/
  /*------*/
  SELECT * FROM nasabah;
  /*-----*/
  UPDATE nasabah
SET alamat_nasabah = 'Jl. Slamet Riyadi No.34',
	modified_date = NOW(),
    modified_by = 'Super Admin'
WHERE nama_nasabah = 'Indri Hapsari';

/* SOAL 2 b.  Cabang dengan kode BRUW pindah alamat ke Jl. A. Yani No.23.*/
/*------*/
  SELECT * FROM cabang_bank;
  /*-----*/
UPDATE cabang_bank
SET alamat_cabang = 'Jl. A. Yani No.23',
	modified_date = NOW(),
    modified_by = 'Admin Ervin'
WHERE kode_cabang = 'BRUW';

/*-------------------------------------------------------------------------*/
/* SOAL 3 a. Nasabah dengan nama Sari Murti menutup rekeningnya.*/

 /*------*/
  SELECT * FROM nasabah;
  /*-----*/
DELETE FROM nasabah
WHERE nama_nasabah = 'Sari Murti'

/* SOAL 3 b.  Cabang dengan nama Bank Rut Unit Yogyakarta menutup kantornya.*/

/*------*/
  SELECT * FROM cabang_bank;
  /*-----*/
DELETE FROM cabang_bank
WHERE nama_cabang = 'Bank Rut Unit Yogyakarta'

/*-------------------------------------------------------------------------*/
/* SOAL 4 a.  Tampilkan nama nasabah, alamat nasabah, jenis transaksi 
dan jumlah transaksi dimana jenis transaksinya adalah kredit dan diurutkan berdasarkan nama nasabah.*/

SELECT  nasabah.nama_nasabah, nasabah.alamat_nasabah, 
		transaksi.jenis_transaksi, transaksi.jumlah
  FROM transaksi 
  INNER JOIN nasabah ON transaksi.id_nasabah = nasabah.id_nasabah
  WHERE jenis_transaksi = 'kredit'
    ORDER BY nasabah.nama_nasabah ASC ;
    
    
/* SOAL 4 b.  Tampilkan tanggal transaksi, nama nasabah, jenis transaksi, dan jumlah transaksi untuk semua transaksi yang terjadi 
dari 15 November 2009 sampai 20 November 2009 dan diurutkan berdasarkan tanggal transaksi dan nama nasabah..*/

SELECT  transaksi.tanggal, nasabah.nama_nasabah, 
			transaksi.jenis_transaksi, transaksi.jumlah
  FROM transaksi 
  INNER JOIN nasabah ON transaksi.id_nasabah = nasabah.id_nasabah
  WHERE transaksi.tanggal BETWEEN '2009-11-15' AND '2009-11-20'
    ORDER BY transaksi.tanggal ASC ;

